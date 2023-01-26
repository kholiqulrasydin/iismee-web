import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/log-book/views/log_book_view.dart';

class LogBookController extends GetxController {
  //TODO: Implement LogBookController

  final sizeControl = Get.find<SizeController>();
  RxList<Map<String, dynamic>> participantList = [
    {'nama': 'Agus Subarjo', 'instansi': 'PT. Gudang Garam tbk'},
    {'nama': 'Nandya Santoso', 'instansi': 'PT. Unilever'},
    {'nama': 'Laila Canggung', 'instansi': 'PT. Yamaha Music'},
    {'nama': 'Agus Subarjo', 'instansi': 'PT. Gudang Garam tbk'},
    {'nama': 'Nandya Santoso', 'instansi': 'PT. Unilever'},
    {'nama': 'Laila Canggung', 'instansi': 'PT. Yamaha Music'},
    {'nama': 'Agus Subarjo', 'instansi': 'PT. Gudang Garam tbk'},
    {'nama': 'Nandya Santoso', 'instansi': 'PT. Unilever'},
    {'nama': 'Laila Canggung', 'instansi': 'PT. Yamaha Music'},
  ].obs;
  RxList<Participant> participantsList = RxList([]);
  Rx<Widget>? table;

  RxInt? selectedParticipant;
  
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

  participantOnTap(int index){
    selectedParticipant = index.obs;
    buildParticipant();
    buildTable();
    update();
  }

  void buildParticipant() {
    participantsList = List.generate(participantList.length, (index) {
      return Participant(
          isSelected: selectedParticipant != null ? selectedParticipant!.value == index : false,
          isTableNull: selectedParticipant == null,
          onTap: (){
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
        ? Participants(participants: participantsList).obs
        : const LogBookTable().obs;
  }

  void createSize(BuildContext context){
    sizeControl.createSize(context);
  }

  void initPage(){
    selectedParticipant = null;
    buildParticipant();
    buildTable();
    update();
  }

}
