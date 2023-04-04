import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/laporan/controllers/chats_controller.dart';
import 'package:iismee/app/modules/laporan/views/laporan_view.dart';

const kTileHeight = 50.0;

const completeColor = Colors.blue;
const inProgressColor = Colors.teal;
const todoColor = Color(0xffd1d2d7);

class LaporanController extends GetxController {
  //TODO: Implement LaporanController
  final sizeControl = Get.find<SizeController>();

  RxInt selectedPage = 1.obs;
  RxInt processIndex = 1.obs;
  RxString? judul;
  RxString? tema;
  Rx<Uint8List>? filePdf;
  RxBool latarBelakang = false.obs;
  RxBool tujuan = false.obs;

  Color getColor(int index) {
    if (index == processIndex.value) {
      return inProgressColor;
    } else if (index < processIndex.value) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  void judulOnChange(String val) {
    judul = val.obs;
    update();
  }

  void temaOnChange(String val) {
    tema = val.obs;
    update();
  }

  void latarBelakangOnChange(bool val) {
    latarBelakang = val.obs;
    update();
  }

  void tujuanOnChange(bool val) {
    tujuan = val.obs;
    update();
  }

  RxList<Map<String, dynamic>>? progressList;

  @override
  void onInit() {
    super.onInit();
    Get.put<ChatsController>(ChatsController());
    sizeControl.createSize(Get.context!);
  }

  @override
  void onReady() {
    super.onReady();
    buildProgressList();
  }

  @override
  void onClose() {
    super.onClose();
    if (Get.isRegistered<ChatsController>()) {
      Get.delete<ChatsController>();
    }
  }

  void nextForm() {
    if (selectedPage.value < 4 && processIndex < 4) {
      selectedPage = selectedPage + 1;
      processIndex = processIndex + 1;
      buildProgressList();
    }
  }

  void changeForm(int index) {
    selectedPage = index.obs;
    buildProgressList();
  }

  buildProgressList() {
    progressList = [
      {'icon': Icons.person, 'title': 'Identitas', 'body': const SizedBox()},
      {
        'icon': Icons.edit_note_rounded,
        'title': 'Form',
        'body': LaporanForm(
          sizeControl: sizeControl,
        )
      },
      {
        'icon': Icons.file_copy_rounded,
        'title': 'Unggah Berkas',
        'body': UploadFile(sizeControl: sizeControl)
      },
      {
        'icon': Icons.task,
        'title': 'Kelengkapan Berkas',
        'body': const SizedBox()
      },
      {'icon': Icons.check, 'title': 'Peninjauan', 'body': const SizedBox()}
    ].obs;
    print('progress list length is : ${progressList!.length}');
    update();
  }
}
