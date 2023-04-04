import 'dart:typed_data';

import 'package:iismee/api/constant/api.dart';

class ProposalApi {
  static Future<bool> isProposalSaved() async {
    return await Api.get(routes: '/proposal/fetch').then((value) =>
        value.statusCode == 200
            ? (value.data!['proposal'] as List).last['fileName'] != null
            : false);
  }

  static Future<int?> isProposalExists() async {
    return await Api.get(routes: '/proposal/fetch').then((value) =>
        value.statusCode == 200
            ? (value.data!['proposal'] as List).last['id']
            : null);
  }

  static Future<bool> beginUpdateProposal(Uint8List file, String judul,
      String tema, bool islatarBlk, bool isTujuan, int docId) async {
    print('your proposal id is ${docId}');
    Response saveDataRes = await Api.post(routes: '/proposal/update', data: {
      'judul': judul,
      'tema': tema,
      'using_latar_belakang': islatarBlk ? 1 : 0,
      'using_tujuan': isTujuan ? 1 : 0,
      'id': docId
    });

    if (saveDataRes.statusCode == 200) {
      print('begin uploading file .. ');
      Response res = await Api.uploadFile(
          file: file,
          routes: '/media/upload',
          body: {'filecontext': 'proposal', 'docId': docId.toString()});
      if (res.statusCode == 200) {
        print('success uploading pdf file');
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> beginSaveProposal(Uint8List file, String judul,
      String tema, bool islatarBlk, bool isTujuan) async {
    int? docId;
    Response saveDataRes = await Api.post(routes: '/proposal/store', data: {
      'judul': judul,
      'tema': tema,
      'using_latar_belakang': islatarBlk,
      'using_tujuan': isTujuan
    });

    if (saveDataRes.statusCode == 200) {
      docId = saveDataRes.data!['result']['id'];
      print('begin uploading file .. ');
      Response res = await Api.uploadFile(
          file: file,
          routes: '/media/upload',
          body: {'filecontext': 'proposal', 'docId': docId.toString()});
      if (res.statusCode == 200) {
        print('success uploading pdf file');
        return true;
      } else {
        if (docId != null) {
          await Api.post(routes: '/proposal/delete', data: {'docId': docId});
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
