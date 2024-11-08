// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import '../services/signalling.service.dart';

// class CallScreen extends StatefulWidget {
//   final String callerId, calleeId;
//   final dynamic offer;
//   const CallScreen({
//     super.key,
//     this.offer,
//     required this.callerId,
//     required this.calleeId,
//   });

//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }

// class _CallScreenState extends State<CallScreen> {
//   // socket instance
//   final socket = SignallingService.instance.socket;

//   // videoRenderer for localPeer
//   final _localRTCVideoRenderer = RTCVideoRenderer();

//   // videoRenderer for remotePeer
//   final _remoteRTCVideoRenderer = RTCVideoRenderer();

//   // mediaStream for localPeer
//   MediaStream? _localStream;

//   // RTC peer connection
//   RTCPeerConnection? _rtcPeerConnection;

//   // list of rtcCandidates to be sent over signalling
//   List<RTCIceCandidate> rtcIceCadidates = [];

//   // media status
//   bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

//   @override
//   void initState() {
//     // initializing renderers
//     _localRTCVideoRenderer.initialize();
//     _remoteRTCVideoRenderer.initialize();

//     // setup Peer Connection
//     _setupPeerConnection();
//     super.initState();
//   }

//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   _setupPeerConnection() async {
//     // create peer connection
//     _rtcPeerConnection = await createPeerConnection({
//       'iceServers': [
//         {
//           'urls': [
//             'stun:stun1.l.google.com:19302',
//             'stun:stun2.l.google.com:19302'
//           ]
//         }
//       ]
//     });

//     // listen for remotePeer mediaTrack event
//     _rtcPeerConnection!.onTrack = (event) {
//       _remoteRTCVideoRenderer.srcObject = event.streams[0];
//       setState(() {});
//     };

//     // get localStream
//     _localStream = await navigator.mediaDevices.getUserMedia({
//       'audio': isAudioOn,
//       'video': isVideoOn
//           ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
//           : false,
//     });

//     // add mediaTrack to peerConnection
//     _localStream!.getTracks().forEach((track) {
//       _rtcPeerConnection!.addTrack(track, _localStream!);
//     });

//     // set source for local video renderer
//     _localRTCVideoRenderer.srcObject = _localStream;
//     setState(() {});

//     // for Incoming call
//     if (widget.offer != null) {
//       // listen for Remote IceCandidate
//       socket!.on("IceCandidate", (data) {
//         String candidate = data["iceCandidate"]["candidate"];
//         String sdpMid = data["iceCandidate"]["id"];
//         int sdpMLineIndex = data["iceCandidate"]["label"];

//         // add iceCandidate
//         _rtcPeerConnection!.addCandidate(RTCIceCandidate(
//           candidate,
//           sdpMid,
//           sdpMLineIndex,
//         ));
//       });

//       // set SDP offer as remoteDescription for peerConnection
//       await _rtcPeerConnection!.setRemoteDescription(
//         RTCSessionDescription(widget.offer["sdp"], widget.offer["type"]),
//       );

//       // create SDP answer
//       RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();

//       // set SDP answer as localDescription for peerConnection
//       _rtcPeerConnection!.setLocalDescription(answer);

//       // send SDP answer to remote peer over signalling
//       socket!.emit("answerCall", {
//         "callerId": widget.callerId,
//         "sdpAnswer": answer.toMap(),
//       });
//     }
//     // for Outgoing Call
//     else {
//       // listen for local iceCandidate and add it to the list of IceCandidate
//       _rtcPeerConnection!.onIceCandidate =
//           (RTCIceCandidate candidate) => rtcIceCadidates.add(candidate);

//       // when call is accepted by remote peer
//       socket!.on("callAnswered", (data) async {
//         // set SDP answer as remoteDescription for peerConnection
//         await _rtcPeerConnection!.setRemoteDescription(
//           RTCSessionDescription(
//             data["sdpAnswer"]["sdp"],
//             data["sdpAnswer"]["type"],
//           ),
//         );

//         // send iceCandidate generated to remote peer over signalling
//         for (RTCIceCandidate candidate in rtcIceCadidates) {
//           socket!.emit("IceCandidate", {
//             "calleeId": widget.calleeId,
//             "iceCandidate": {
//               "id": candidate.sdpMid,
//               "label": candidate.sdpMLineIndex,
//               "candidate": candidate.candidate
//             }
//           });
//         }
//       });

//       // create SDP Offer
//       RTCSessionDescription offer = await _rtcPeerConnection!.createOffer();

//       // set SDP offer as localDescription for peerConnection
//       await _rtcPeerConnection!.setLocalDescription(offer);

//       // make a call to remote peer over signalling
//       socket!.emit('makeCall', {
//         "calleeId": widget.calleeId,
//         "sdpOffer": offer.toMap(),
//       });
//     }
//   }

//   _leaveCall() {
//     Navigator.pop(context);
//   }

//   _toggleMic() {
//     // change status
//     isAudioOn = !isAudioOn;
//     // enable or disable audio track
//     _localStream?.getAudioTracks().forEach((track) {
//       track.enabled = isAudioOn;
//     });
//     setState(() {});
//   }

//   _toggleCamera() {
//     // change status
//     isVideoOn = !isVideoOn;

//     // enable or disable video track
//     _localStream?.getVideoTracks().forEach((track) {
//       track.enabled = isVideoOn;
//     });
//     setState(() {});
//   }

//   _switchCamera() {
//     // change status
//     isFrontCameraSelected = !isFrontCameraSelected;

//     // switch camera
//     _localStream?.getVideoTracks().forEach((track) {
//       // ignore: deprecated_member_use
//       track.switchCamera();
//     });
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         title: const Text("P2P Call App"),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Stack(children: [
//                 RTCVideoView(
//                   _remoteRTCVideoRenderer,
//                   objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//                 ),
//                 Positioned(
//                   right: 20,
//                   bottom: 20,
//                   child: SizedBox(
//                     height: 150,
//                     width: 120,
//                     child: RTCVideoView(
//                       _localRTCVideoRenderer,
//                       mirror: isFrontCameraSelected,
//                       objectFit:
//                           RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//                     ),
//                   ),
//                 )
//               ]),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   IconButton(
//                     icon: Icon(isAudioOn ? Icons.mic : Icons.mic_off),
//                     onPressed: _toggleMic,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.call_end),
//                     iconSize: 30,
//                     onPressed: _leaveCall,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.cameraswitch),
//                     onPressed: _switchCamera,
//                   ),
//                   IconButton(
//                     icon: Icon(isVideoOn ? Icons.videocam : Icons.videocam_off),
//                     onPressed: _toggleCamera,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _localRTCVideoRenderer.dispose();
//     _remoteRTCVideoRenderer.dispose();
//     _localStream?.dispose();
//     _rtcPeerConnection?.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';

class CallScreen extends StatefulWidget {
  final String callerId, calleeId;
  final dynamic offer;

  const CallScreen({
    super.key,
    this.offer,
    required this.callerId,
    required this.calleeId,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
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
    _localRTCVideoRenderer.initialize();
    _remoteRTCVideoRenderer.initialize();
    _setupPeerConnection();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
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
