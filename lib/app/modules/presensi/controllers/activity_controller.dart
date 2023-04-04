import 'dart:typed_data';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iismee/api/logbook.dart';
import 'package:iismee/api/presention.dart';

class ActivityController extends GetxController {
  //TODO: Implement LaporanController
  RxList<CalendarEventData> presentionEvents = [
    CalendarEventData(
      title: 'Present',
      date: DateTime(2022, 11, 10),
      event: "Presention",
    ),
    CalendarEventData(
      title: 'Present',
      date: DateTime(2022, 11, 24),
      event: "Presention",
    )
  ].obs;

  Rx<EventController> eventController = EventController().obs;
  Rx<GlobalKey<MonthViewState>> monthViewKey = GlobalKey<MonthViewState>().obs;
  RxBool onMonthSelection = false.obs;
  RxString? details;
  RxString? problem;
  RxString? solution;
  RxBool isWithEmployee = false.obs;
  RxBool isWithTeam = false.obs;
  Rx<Uint8List>? imageFile;
  RxBool onAsync = false.obs;
  RxBool isExists = false.obs;

  Rx<GlobalKey<NavigatorState>> activityState = GlobalKey<NavigatorState>().obs;

  void save() async {
    onAsync = true.obs;
    update();
    if (details != null &&
        problem != null &&
        solution != null &&
        imageFile != null) {
      bool isSaved = await LogbookApi.save(
          details!.value,
          problem!.value,
          solution!.value,
          isWithEmployee.value,
          isWithTeam.value,
          imageFile!.value);
      if (isSaved) {
        onAsync = false.obs;
        update();
        Get.defaultDialog(
          navigatorKey: activityState.value,
          backgroundColor: Colors.teal.shade600,
          title: 'Success',
          titleStyle: TextStyle(color: Colors.white),
          content: Column(
            children: [
              Text(
                'Logbook berhasil disimpan',
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
          navigatorKey: activityState.value,
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

  checkIfExists() async {
    isExists = (await LogbookApi.checkIfExists()).obs;
    update();
  }

  detailsOnChanged(String val) {
    details = val.obs;
    update();
  }

  problemOnChanged(String val) {
    problem = val.obs;
    update();
  }

  solutionOnChanged(String val) {
    solution = val.obs;
    update();
  }

  void isWithEmployeeChanged(bool? val) {
    isWithEmployee = val!.obs;
    update();
  }

  void isWithTeamChanged(bool? val) {
    isWithTeam = val!.obs;
    update();
  }

  imageFileOnChanged(Uint8List bytes) {
    imageFile = bytes.obs;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getPresentionData();
  }

  @override
  void onReady() {
    super.onReady();
    if (monthViewKey.value.currentState != null) {
      monthViewKey.value.currentState!.animateToMonth(DateTime.now());
      eventController.value.addAll(presentionEvents);
    }
    checkIfExists();
  }

  @override
  void onClose() {
    super.onClose();
    eventController.value.dispose();
    if (monthViewKey.value.currentState != null) {
      monthViewKey.value.currentState!.dispose();
      print('Activity Presention is Disposed .. ');
      print('Leaving now');
    }
  }

  void getPresentionData() async {
    List data = await PresentionApi.getPresentionData();
    List<CalendarEventData> events = [];
    data.forEach((element) {
      presentionEvents.add(CalendarEventData(
        title: 'Present',
        date: DateTime.parse(element['created_at']),
        event: "Presention",
      ));
      presentionEvents = events.obs;
    });
  }

  openCloseMonthSelector() {
    onMonthSelection.value
        ? onMonthSelection = false.obs
        : onMonthSelection = true.obs;
    update();
  }
}
