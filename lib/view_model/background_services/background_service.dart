import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';

Future<void> initializeServices() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
      autoStart: true,
    ),
    iosConfiguration: IosConfiguration(),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  // Initialize and connect the socket
  SignallingService.instance.init(
    websocketUrl: "http://192.168.1.2:4004",
    selfCallerID: 'manish',
  );

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    // Optionally, you can handle reconnection logic or pinging here
    if (!SignallingService.instance.isConnected) {
      SignallingService.instance.init(
        websocketUrl: "http://192.168.1.2:4004",
        selfCallerID: 'mainsh rawat',
      );
    }
  });
}
