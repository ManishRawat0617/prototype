import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CallController extends GetxController {
  var incomingSDPOffer = Rxn<Map<String, dynamic>>();

  void setIncomingCall(Map<String, dynamic> data) {
    incomingSDPOffer.value = data;
  }

  void clearIncomingCall() {
    incomingSDPOffer.value = null;
  }
}

class CallingSession {
  Future<void> postCallingSession(
      CallStarted, CallEnded, CallerId, calleeId) async {
    // API Endpoint
    final url = Uri.parse('http://192.168.1.3:9090/calllingSession/ca');

    // Data to send in the request body
    final data = {
      "caller_id": CallerId.toString(),
      "callee_id": calleeId.toString(),
      "started_at": CallStarted.toString(),
      "ended_at": CallEnded.toString()
    };
    print("this is the data for upload:");
    print(data);

    try {
      // Making the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
        },
        body: jsonEncode(data), // Convert the data to JSON format
      );

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful request
        final responseData = jsonDecode(response.body);
        print('Response: $responseData');
      } else {
        // Error occurred
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
