import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';

class CallView extends StatefulWidget {
  final String callerId, calleeId;
  final dynamic offer;

  const CallView({
    super.key,
    this.offer,
    required this.callerId,
    required this.calleeId,
    //required Null Function(dynamic accepted) onCallResponse,
  });

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  final socket = SignallingService.instance.socket;
  final _localRTCVideoRenderer = RTCVideoRenderer();
  final _remoteRTCVideoRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  RTCPeerConnection? _rtcPeerConnection;
  List<RTCIceCandidate> rtcIceCandidates = [];
  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

  @override
  void initState() {
    super.initState();
    _makecall(widget.calleeId);
    _localRTCVideoRenderer.initialize();
    _remoteRTCVideoRenderer.initialize();
    _listenForResponse();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _listenForResponse() {
    socket?.on("accept", (data) {
      var calleeId = data["calleeId"];
      var response = data['reply'];

      // setState(() {
      //   callStatus = response;
      // });
    });
    // it will make the call only if the reply is accept

    _setupPeerConnection();
  }

  void _makecall(String calleeId) {
    socket
        ?.emit("callUser", {"callerId": widget.callerId, "calleeId": calleeId});
  }

  Future<void> _setupPeerConnection() async {
    try {
      _rtcPeerConnection = await createPeerConnection({
        'iceServers': [
          {
            'urls': [
              'stun:stun1.l.google.com:19302',
              'stun:stun2.l.google.com:19302'
            ]
          }
        ]
      });

      _rtcPeerConnection!.onTrack = (event) {
        _remoteRTCVideoRenderer.srcObject = event.streams[0];
        setState(() {});
      };

      _localStream = await _getUserMedia();
      _localRTCVideoRenderer.srcObject = _localStream;

      _addLocalTracksToPeer();

      if (widget.offer != null) {
        _handleIncomingCall();
      } else {
        _makeOutgoingCall();
      }
    } catch (e) {
      _showErrorSnackbar("Failed to set up peer connection: $e");
    }
  }

  Future<MediaStream> _getUserMedia() async {
    return await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });
  }

  void _addLocalTracksToPeer() {
    _localStream?.getTracks().forEach((track) {
      _rtcPeerConnection?.addTrack(track, _localStream!);
    });
  }

  void _handleIncomingCall() async {
    socket?.on("IceCandidate", (data) {
      var candidate = RTCIceCandidate(
        data["iceCandidate"]["candidate"],
        data["iceCandidate"]["id"],
        data["iceCandidate"]["label"],
      );
      _rtcPeerConnection?.addCandidate(candidate);
    });

    await _rtcPeerConnection?.setRemoteDescription(
      RTCSessionDescription(widget.offer["sdp"], widget.offer["type"]),
    );

    var answer = await _rtcPeerConnection!.createAnswer();
    await _rtcPeerConnection!.setLocalDescription(answer);

    socket?.emit("answerCall", {
      "callerId": widget.callerId,
      "sdpAnswer": answer.toMap(),
    });
  }

  void _makeOutgoingCall() async {
    _rtcPeerConnection?.onIceCandidate =
        (candidate) => rtcIceCandidates.add(candidate);

    socket?.on("callAnswered", (data) async {
      await _rtcPeerConnection?.setRemoteDescription(
        RTCSessionDescription(
            data["sdpAnswer"]["sdp"], data["sdpAnswer"]["type"]),
      );

      _sendLocalIceCandidates();
    });

    var offer = await _rtcPeerConnection!.createOffer();
    await _rtcPeerConnection!.setLocalDescription(offer);

    socket?.emit('makeCall', {
      "calleeId": widget.calleeId,
      "sdpOffer": offer.toMap(),
    });
  }

  void _sendLocalIceCandidates() {
    for (var candidate in rtcIceCandidates) {
      socket?.emit("IceCandidate", {
        "calleeId": widget.calleeId,
        "iceCandidate": {
          "id": candidate.sdpMid,
          "label": candidate.sdpMLineIndex,
          "candidate": candidate.candidate
        }
      });
    }
  }

  void _leaveCall() {
    Navigator.pop(context);
    socket?.emit("endCall", {
      "callerId": widget.callerId,
      "calleeId": widget.calleeId,
    });
  }

  void _toggleMic() {
    isAudioOn = !isAudioOn;
    _localStream
        ?.getAudioTracks()
        .forEach((track) => track.enabled = isAudioOn);
    setState(() {});
  }

  void _toggleCamera() {
    isVideoOn = !isVideoOn;
    _localStream
        ?.getVideoTracks()
        .forEach((track) => track.enabled = isVideoOn);
    setState(() {});
  }

  void _switchCamera() {
    isFrontCameraSelected = !isFrontCameraSelected;
    _localStream?.getVideoTracks().forEach((track) {
      track.switchCamera();
    });
    setState(() {});
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("P2P Call App"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  RTCVideoView(
                    _remoteRTCVideoRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: SizedBox(
                      height: 150,
                      width: 120,
                      child: RTCVideoView(
                        _localRTCVideoRenderer,
                        mirror: isFrontCameraSelected,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(isAudioOn ? Icons.mic : Icons.mic_off),
                    onPressed: _toggleMic,
                  ),
                  IconButton(
                    icon: const Icon(Icons.call_end),
                    iconSize: 30,
                    onPressed: _leaveCall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.cameraswitch),
                    onPressed: _switchCamera,
                  ),
                  IconButton(
                    icon: Icon(isVideoOn ? Icons.videocam : Icons.videocam_off),
                    onPressed: _toggleCamera,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _localRTCVideoRenderer.dispose();
    _remoteRTCVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();
    socket?.off("IceCandidate");
    socket?.off("callAnswered");
    super.dispose();
  }
}
