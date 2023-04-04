import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import 'package:iismee/api/constant/bytes/equality.dart';

const hostUrl = "https://iismee.com/api";

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

class Api {
  static final Random _rnd = Random();
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static final storage = GetStorage();

  static String? guessFileType(Uint8List bytes) {
    final pdfSignature = Uint8List.fromList([0x25, 0x50, 0x44, 0x46, 0x2D]);
    final listEquality = ListEquality<int>();
    if (bytes.lengthInBytes >= 8) {
      if (bytes[0] == 0x89 &&
          bytes[1] == 0x50 &&
          bytes[2] == 0x4E &&
          bytes[3] == 0x47 &&
          bytes[4] == 0x0D &&
          bytes[5] == 0x0A &&
          bytes[6] == 0x1A &&
          bytes[7] == 0x0A) {
        return 'png';
      } else if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
        return 'jpg';
      } else if (bytes[0] == 0x47 &&
          bytes[1] == 0x49 &&
          bytes[2] == 0x46 &&
          bytes[3] == 0x38 &&
          (bytes[4] == 0x37 || bytes[4] == 0x39) &&
          bytes[5] == 0x61) {
        return 'gif';
      } // add more file types here
      if (bytes.length > 3 &&
          (bytes[0] == 0x25 &&
              bytes[1] == 0x50 &&
              bytes[2] == 0x44 &&
              bytes[3] == 0x46)) {
        return 'pdf';
      }
    }
    return null; // unknown file type
  }

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

  static Future<Response> uploadImage(
      {required Uint8List file,
      required String routes,
      required Map<String, String> body}) async {
    html.File resultImageFile =
        html.File(file, '${getRandomString(5)}.${guessFileType(file) ?? ''}');
    String token = storage.read('token');
    try {
      print(Uri.parse('$hostUrl$routes').toString());
      // Map<String, dynamic> fields = {'file': resultImageFile};
      final request =
          http.MultipartRequest('POST', Uri.parse('$hostUrl$routes'));
      // request.fields['filecontext'] = body['filecontext'] ?? '';
      // if (body.containsKey('docId')) {
      //   request.fields['docId'] = body['docId']!;
      // }
      request.fields.addAll(body);
      request.headers.addAll({
        // "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      });
      String extFile = guessFileType(file) ?? '';
      print('File extension is' + extFile);
      request.files.add(
        http.MultipartFile.fromString(
          'file',
          resultImageFile.toString(),
          filename: '${getRandomString(5)}.${guessFileType(file) ?? ''}',
        ),
      );

      final streamedRespnse = await request.send();
      final response = await http.Response.fromStream(streamedRespnse);
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

  static Future<Response> uploadFile(
      {required Uint8List file,
      required String routes,
      required Map<String, String> body}) async {
    html.File resultImageFile =
        html.File(file, '${getRandomString(5)}.${guessFileType(file) ?? ''}');
    String token = storage.read('token');
    try {
      print(Uri.parse('$hostUrl$routes').toString());
      // Map<String, dynamic> fields = {'file': resultImageFile};
      final request =
          http.MultipartRequest('POST', Uri.parse('$hostUrl$routes'));
      // request.fields['filecontext'] = body['filecontext'] ?? '';
      // if (body.containsKey('docId')) {
      //   request.fields['docId'] = body['docId']!;
      // }
      request.fields.addAll(body);
      request.headers.addAll({
        // "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      });
      String extFile = guessFileType(file) ?? '';
      print('File extension is' + extFile);
      request.files.add(
        http.MultipartFile.fromString(
          'file',
          resultImageFile.toString(),
          filename: '${getRandomString(5)}.${guessFileType(file) ?? ''}',
        ),
      );

      final streamedRespnse = await request.send();
      final response = await http.Response.fromStream(streamedRespnse);
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
}

class Response {
  final int? statusCode;
  final Map<String, dynamic>? data;

  Response({this.statusCode, this.data});
}
