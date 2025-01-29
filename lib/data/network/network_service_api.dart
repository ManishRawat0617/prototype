import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prototype/data/exception/app_exception.dart';
import 'package:prototype/data/network/base_api_network.dart';

class NetworkServiceApi implements BaseApiNetwork {
  final client = http.Client();

  // get the data from the API
  @override
  Future<dynamic> getData(String url) async {
    try {
      // Make the GET request
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["data"][0]["id"]);

        // Check if the response data is a list
        if (data is List) {
          // for (var item in data[""]) {
          //   if (item is Map<String, dynamic> && item['id'] != null) {
          //     print('ID: ${item['id']}');
          //   }
          // }
        } else {
          print('Response is not a list.');
        }

        return data;
      } else {
        throw FetchDataException(
            message: "Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print('Error: $error');
      throw FetchDataException(message: error.toString());
    }
  }

  // post data to the API
  @override
  Future<dynamic> postData(String url, var body) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json', // Explicitly set the content type
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        throw RequestTimeOutException(message: "Bad Request: ${response.body}");
      } else if (response.statusCode == 500) {
        throw FetchDataException(message: "Server Error: ${response.body}");
      } else {
        throw FetchDataException(
            message: "Unexpected Error: ${response.statusCode}");
      }
    } on SocketException {
      throw NoInternetException(message: "No internet connection");
    } on TimeoutException {
      throw NoInternetException(message: "Request timeout");
    } catch (error) {
      throw FetchDataException(message: error.toString());
    }
  }

  // Handle response and status codes
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw RequestTimeOutException(message: "Bad Request: ${response.body}");
      case 500:
        throw FetchDataException(message: "Internal Server Error");
      default:
        throw FetchDataException(
          message: "Error occurred with status code: ${response.statusCode}",
        );
    }
  }
}
