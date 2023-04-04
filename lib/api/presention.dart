import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iismee/api/constant/api.dart';

class PresentionApi {
  static void showToast(String messages, bool alert, FToast fToast) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: alert ? Colors.amber : Colors.teal,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            alert ? Icons.warning_amber_outlined : Icons.check,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            messages,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: const Duration(seconds: 2),
    );
  }

  static Future<bool> present(FToast ftoast, bool isK3Used, bool isLate,
      String motivations, Uint8List file) async {
    int? presentingDocId;
    try {
      Response response = await Api.post(routes: '/presention/present', data: {
        'isK3Used': isK3Used,
        'isLate': isLate,
        'todays_motivations': motivations
      });
      if (response.statusCode == 200) {
        presentingDocId = response.data!['latestData']['id'];
        showToast('Data lengkap, mulai unggah foto', false, ftoast);
        print(
            '${'uploading file with ' + (response.data!['latestData']['id']).toString()} id');
        Response res =
            await Api.uploadImage(file: file, routes: '/media/upload', body: {
          'filecontext': 'presention',
          'docId': (response.data!['latestData']['id']).toString(),
        });
        if (res.statusCode == 200) {
          showToast('Berhasil presensi', false, ftoast);
          print(res.data.toString());
          print(response.data.toString());
        }
      }
      return true;
    } catch (e) {
      if (presentingDocId != null) {
        Response deleteRes = await Api.post(
            routes: '/presention/delete', data: {'docId': presentingDocId});
      }
      print(e.toString());
      showToast('Gagal presensi, coba lagi beberapa saat', true, ftoast);
      return false;
    }
  }

  static Future<int> isTodayPresent() async {
    print('begin checking presention');
    try {
      Response res = await Api.get(routes: '/presention/fetch');

      if (res.statusCode == 200 && res.data != null) {
        List presentionData = res.data!['presentions'] as List;
        Map<String, dynamic> presentNow = presentionData.last;
        if (DateTime.parse(presentNow['created_at']).day ==
            DateTime.now().day) {
          return 1;
        } else {
          return 2;
        }
      } else {
        return 2;
      }
    } catch (e) {
      print(e.toString());
      return 2;
    }
  }

  static Future<List> getPresentionData() async {
    List presentionData = [];
    try {
      print('begin getting presention data');
      Response res = await Api.get(routes: '/presention/fetch');
      if (res.statusCode == 200 && res.data!.containsKey('presentions')) {
        presentionData = res.data!['presentions'] as List;
        print(presentionData.toString());
      }
    } catch (e) {
      print(e.toString());
    }
    return presentionData;
  }
}
