import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prototype/data/exception/app_exception.dart';
import 'package:prototype/data/network/base_api_network.dart';

class NetworkServiceApi implements BaseApiNetwork {
  final http.Client client = http.Client();

  // Fetch data from API
  @override
  Future<dynamic> getData(String url) async {
    try {
      final response = await client.get(Uri.parse(url)).timeout(
            const Duration(seconds: 10),
          );

      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException(message: "No internet connection");
    } on TimeoutException {
      throw RequestTimeOutException(message: "Request timeout");
    } catch (error) {
      throw FetchDataException(message: "Unexpected error: $error");
    }
  }

  // Post data to the API
  @override
  Future<dynamic> postData(String url, dynamic body) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
      );

      return _returnResponse(response);
    }
    //  on SocketException {
    //   throw NoInternetException(message: "No internet connection");
    // } on TimeoutException {
    //   throw RequestTimeOutException(message: "Request timeout");
    // }
    catch (error) {
      throw FetchDataException(message: "Unexpected error: $error");
    }
  }

  // Handle response and status codes
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          return jsonDecode(response.body);
        } on FormatException {
          throw FetchDataException(message: "Invalid JSON format");
        }
      case 401:
        try {
          return jsonDecode(response.body);
        } on FormatException {
          throw FetchDataException(message: "Invalid JSON format");
        }
      case 400:
        throw RequestTimeOutException(message: "Bad Request: ${response.body}");
      case 500:
        throw FetchDataException(message: "Internal Server Error");
      default:
        throw FetchDataException(
            message:
                "Unexpected Error: ${response.statusCode} - ${response.body}");
    }
  }

  // Close the HTTP client when no longer needed
  void dispose() {
    client.close();
  }
}
