import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iismee/api/proposal.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/laporan/controllers/chats_controller.dart';
import 'package:iismee/app/modules/laporan/views/laporan_view.dart';
import 'package:provider/provider.dart';

const kTileHeight = 50.0;

const completeColor = Colors.blue;
const inProgressColor = Colors.teal;
const todoColor = Color(0xffd1d2d7);

class LaporanController extends GetxController {
  //TODO: Implement LaporanController
  final sizeControl = Get.find<SizeController>();

  Rx<GlobalKey<NavigatorState>> laporanState = GlobalKey<NavigatorState>().obs;

  RxInt selectedPage = 1.obs;
  RxInt processIndex = 1.obs;
  RxString? judul;
  RxString? tema;
  Rx<Uint8List>? filePdf;
  RxBool latarBelakang = false.obs;
  RxBool tujuan = false.obs;
  RxBool onAsync = false.obs;
  bool isProposalExists = false;
  int? proposalId;
  bool isProposalSaved = false;

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

  void checkIfExists() async {
    int? id = await ProposalApi.isProposalExists();
    isProposalExists = id != null;
    if (isProposalExists) {
      selectedPage = 3.obs;
      processIndex = 3.obs;
      proposalId = id;
      update();
    }
  }

  void checkIfSaved() async {
    bool saved = await ProposalApi.isProposalSaved();
    isProposalSaved = saved;
    if (isProposalExists) {
      selectedPage = 4.obs;
      processIndex = 4.obs;
      update();
    }
  }

  void saveData() async {
    onAsync = true.obs;
    update();
    if (judul != null && tema != null && filePdf != null) {
      bool isSaved = isProposalExists
          ? await ProposalApi.beginUpdateProposal(filePdf!.value, judul!.value,
              tema!.value, latarBelakang.value, tujuan.value, proposalId!)
          : await ProposalApi.beginSaveProposal(filePdf!.value, judul!.value,
              tema!.value, latarBelakang.value, tujuan.value);
      if (isSaved) {
        onAsync = false.obs;
        selectedPage = 4.obs;
        processIndex = 4.obs;
        update();
        Get.defaultDialog(
          navigatorKey: laporanState.value,
          backgroundColor: Colors.teal.shade600,
          title: 'Success',
          titleStyle: TextStyle(color: Colors.white),
          content: Column(
            children: [
              Text(
                'Proposal berhasil disimpan',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '(ketuk / klik mana saja untuk keluar)',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
          // textConfirm: 'Tutup',
        );
      } else {
        onAsync = false.obs;
        update();
        Get.defaultDialog(
          navigatorKey: laporanState.value,
          backgroundColor: Colors.amber.shade600,
          titleStyle: TextStyle(color: Colors.white),
          title: 'Failed',
          content: Column(
            children: [
              Text(
                'Gagal menyimpan proposal, periksa kembali koneksi internet',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '(ketuk / klik mana saja untuk keluar)',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
          // textConfirm: 'Tutup',
        );
      }
    }
    checkIfExists();
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
    checkIfExists();
    checkIfSaved();
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
        'body': KelengkapanBerkas()
      },
      {
        'icon': Icons.check,
        'title': 'Peninjauan',
        'body': SizedBox(
          child: Center(
              child: Column(
            children: [
              Text('Dokumen sedang ditinjau dan dinilai'),
              SizedBox(
                height: 30,
              ),
              Text('Ingin menyunting ?'),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {
                  processIndex = 1.obs;
                  selectedPage = 1.obs;
                  update();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                color: Colors.blue,
                minWidth: 200,
                child: const Text(
                  'Upload ulang proposal',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          )),
        )
      }
    ].obs;
    print('progress list length is : ${progressList!.length}');
    update();
  }
}
