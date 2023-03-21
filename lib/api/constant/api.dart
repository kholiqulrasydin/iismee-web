import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const hostUrl = "http://127.0.0.1:8000/api";

class Api {
  static final storage = GetStorage();
  static Future<Response> get({required String routes}) async {
    String token = storage.read('token');
    http.Response response = await http.get(
      Uri.parse('$hostUrl$routes'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return Response(
        statusCode:
            (jsonDecode(response.body) as Map<String, dynamic>)['statusCode'],
        data: (jsonDecode(response.body)
            as Map<String, dynamic>)['responseData']);
  }

  static Future<Response> post(
      {required String routes, required Map<String, dynamic> data}) async {
    String token = storage.read('token');
    try {
      print(Uri.parse('$hostUrl$routes').toString());
      http.Response response = await http.post(Uri.parse('$hostUrl$routes'),
          headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(data));

      return Response(
          statusCode:
              (jsonDecode(response.body) as Map<String, dynamic>)['statusCode'],
          data: (jsonDecode(response.body)
              as Map<String, dynamic>)['responseData']);
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 500, data: {});
    }
  }

  static Future<Response> postOnce(
      {required String routes, required Map<String, dynamic> data}) async {
    try {
      print(Uri.parse('$hostUrl$routes').toString());
      http.Response response = await http.post(Uri.parse('$hostUrl$routes'),
          headers: {
            // "Access-Control-Allow-Origin":
            //     "*", // Required for CORS support to work
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));
      return Response(
          statusCode:
              (jsonDecode(response.body) as Map<String, dynamic>)['statusCode'],
          data: (jsonDecode(response.body)
              as Map<String, dynamic>)['responseData']);
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 500, data: {});
    }
  }

  static Future<Response> getOnce({required String routes}) async {
    http.Response response = await http.get(
      Uri.parse('$hostUrl$routes'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    return Response(
        statusCode:
            (jsonDecode(response.body) as Map<String, dynamic>)['statusCode'],
        data: (jsonDecode(response.body)
            as Map<String, dynamic>)['responseData']);
  }
}

class Response {
  final int? statusCode;
  final Map<String, dynamic>? data;

  Response({this.statusCode, this.data});
}
