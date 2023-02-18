import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/participant-score/views/participant_score_view.dart';

class ParticipantScoreController extends GetxController {
  //TODO: Implement ParticipantScoreController
  final sizeControl = Get.find<SizeController>();
  RxList<String> mpk =
      ['Perencanaan Program', 'Pelaksanaan Program', 'Pelaporan Program'].obs;

  RxList<Map<String, dynamic>> participantList = [
    {'nama': 'Agus Subarjo', 'instansi': 'PT. Gudang Garam tbk'},
    {'nama': 'Nandya Santoso', 'instansi': 'PT. Unilever'},
    {'nama': 'Laila Canggung', 'instansi': 'PT. Yamaha Music'},
  ].obs;
  RxList<PageMenu> menuPages = RxList([]);
  RxList<Participant> participantsList = RxList([]);
  Rx<Widget> table = Container().obs;

  RxInt? selectedParticipant;
  RxInt selectedMpk = 0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    initPage();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectMpk(int index) {
    selectedMpk = index.obs;
    selectedParticipant = null;
    buildPageMenu();
    buildTable();
    buildParticipant();
    update();
  }

  void createSize(BuildContext context) {
    sizeControl.createSize(context);
  }

  void initPage() {
    buildPageMenu();
    selectedParticipant = 1.obs;
    buildTable();
    buildParticipant();
    update();
  }

  void buildPageMenu() {
    menuPages = List.generate(mpk.length, (index) {
      return PageMenu(
          title: mpk[index],
          isSelected: selectedMpk.value == index,
          onTap: () {
            selectMpk(index);
          });
    }).toList().obs;
  }

  participantOnTap(int index) {
    selectedParticipant = index.obs;
    buildParticipant();
    buildTable();
    update();
  }

  void buildParticipant() {
    participantsList = List.generate(participantList.length, (index) {
      return Participant(
          isSelected: selectedParticipant != null
              ? selectedParticipant!.value == index
              : false,
          isTableNull: selectedParticipant == null,
          onTap: () {
            participantOnTap(index);
          },
          name: participantList[index]['nama'],
          sizeControl: sizeControl,
          details: [
            ParticipantDetail(
                sizeControl: sizeControl,
                title: 'Nama Instansi : ',
                detail: participantList[index]['instansi']),
            ParticipantDetail(
                sizeControl: sizeControl, title: 'Status : ', detail: 'Aktif')
          ]);
    }).toList().obs;
  }

  void buildTable() {
    table = selectedParticipant == null
        ? Text(
            'Harap pilih salah satu Mahasiswa terlebih dahulu\nuntuk melihat nilai Mata Kuliah ${mpk[selectedMpk.value]}',
            textAlign: TextAlign.center,
          ).obs
        : getScoringTable().obs;
  }

  Widget getScoringTable() {
    late Widget result;
    switch (selectedMpk.value) {
      case 0:
        result = PerencanaanProgramA();
        break;
      case 1:
        result = PerencanaanProgramA();
        break;
      case 2:
        result = PerencanaanProgramA();
        break;

      default:
        result = Container();
    }
    return result;
  }
}
