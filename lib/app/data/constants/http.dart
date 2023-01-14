import 'dart:convert';

import 'package:http/http.dart' as http;

const hostUrl = "https://ewalletpngapi.herokuapp.com/";

class HttpFunct {
  static Future<Response> get({required String routes}) async {
    http.Response response =
        await http.get(Uri.parse('$hostUrl$routes'), headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });

    return Response(
        statusCode:
            (jsonDecode(response.body) as Map<String, dynamic>)['statusCode'],
        data: (jsonDecode(response.body)
            as Map<String, dynamic>)['responseData']);
  }

  static Future<Response> post(
      {required String routes, required Map<String, dynamic> data}) async {
    try {
      print(Uri.parse('$hostUrl$routes').toString());
      http.Response response = await http.post(Uri.parse('$hostUrl$routes'),
          headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            'Accept': 'application/json',
            'Content-Type': 'application/json'
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

  static Future<Response> postv2(
      {required String routes,
      required Map<String, dynamic> data,
      required String token}) async {
    try {
      print(Uri.parse('$hostUrl$routes').toString());
      http.Response response =
          await http.post(Uri.parse('${hostUrl}v2/$routes'),
              headers: {
                "Access-Control-Allow-Origin":
                    "*", // Required for CORS support to work
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'x-auth': token
              },
              body: jsonEncode(data));

      return Response(
          statusCode:
              (jsonDecode(response.body) as Map<String, dynamic>)['statusCode'],
          data: (jsonDecode(response.body) as Map<String, dynamic>));
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 500, data: {});
    }
  }
}

class Response {
  final int? statusCode;
  final Map<String, dynamic>? data;

  Response({this.statusCode, this.data});
}
