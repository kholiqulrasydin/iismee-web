import 'dart:typed_data';

import 'package:iismee/api/constant/api.dart';

class LogbookApi {
  static Future<bool> save(String details, String problem, String solution,
      bool isWithEmployee, bool isWithTeam, Uint8List file) async {
    int? docId;
    Response saveDataRes = await Api.post(routes: '/activity/store', data: {
      'details': details,
      'problem': problem,
      'solution': solution,
      'is_with_employee': isWithEmployee ? 1 : 0,
      'is_with_team': isWithTeam ? 1 : 0
    });

    if (saveDataRes.statusCode == 200) {
      docId = saveDataRes.data!['activity']['id'];
      print('begin uploading file .. ');
      Response res = await Api.uploadFile(
          file: file,
          routes: '/media/upload',
          body: {'filecontext': 'logbook', 'docId': docId.toString()});
      if (res.statusCode == 200) {
        print('success uploading pdf file');
        return true;
      } else {
        if (docId != null) {
          await Api.post(routes: '/activity/delete', data: {'docId': docId});
        }
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> checkIfExists() async {
    return await Api.get(routes: 'activity/check').then(
        (value) => value.statusCode == 200 ? value.data!['result'] : false);
  }
}
