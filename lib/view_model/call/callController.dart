import 'package:get/get.dart';

class CallController extends GetxController {
  var incomingSDPOffer = Rxn<Map<String, dynamic>>();

  void setIncomingCall(Map<String, dynamic> data) {
    incomingSDPOffer.value = data;
  }

  void clearIncomingCall() {
    incomingSDPOffer.value = null;
  }
}
