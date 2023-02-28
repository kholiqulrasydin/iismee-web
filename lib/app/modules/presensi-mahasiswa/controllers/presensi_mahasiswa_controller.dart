import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresensiMahasiswaController extends GetxController {
  //TODO: Implement PresensiMahasiswaController

  RxList<Map<String, dynamic>> participantList = [
    {
      'nama': 'Agus Subarjo',
      'instansi': 'PT. Gudang Garam tbk',
      'nim': '190581397089',
      'statusPresensiHariIni': 0
    },
    {
      'nama': 'Nandya Santoso',
      'instansi': 'PT. Unilever',
      'nim': '190581397089',
      'statusPresensiHariIni': 1
    },
    {
      'nama': 'Laila Canggung',
      'instansi': 'PT. Yamaha Music',
      'nim': '190581397089',
      'statusPresensiHariIni': 2
    },
    {
      'nama': 'Agus Subarjo',
      'instansi': 'PT. Gudang Garam tbk',
      'nim': '190581397089',
      'statusPresensiHariIni': 0
    },
    {
      'nama': 'Nandya Santoso',
      'instansi': 'PT. Unilever',
      'nim': '190581397089',
      'statusPresensiHariIni': 1
    },
    {
      'nama': 'Laila Canggung',
      'instansi': 'PT. Yamaha Music',
      'nim': '190581397089',
      'statusPresensiHariIni': 0
    },
    {
      'nama': 'Agus Subarjo',
      'instansi': 'PT. Gudang Garam tbk',
      'nim': '190581397089',
      'statusPresensiHariIni': 1
    },
    {
      'nama': 'Nandya Santoso',
      'instansi': 'PT. Unilever',
      'nim': '190581397089',
      'statusPresensiHariIni': 0
    },
    {
      'nama': 'Laila Canggung',
      'instansi': 'PT. Yamaha Music',
      'nim': '190581397089',
      'statusPresensiHariIni': 0
    },
  ].obs;

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

  RxInt? selectedParticipant = 1.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (monthViewKey.value.currentState != null) {
      monthViewKey.value.currentState!.animateToMonth(DateTime.now());
      eventController.value.addAll(presentionEvents);
    }
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

  openCloseMonthSelector() {
    onMonthSelection.value
        ? onMonthSelection = false.obs
        : onMonthSelection = true.obs;
    update();
  }

  selectParticipant(int index) {
    selectedParticipant = index.obs;
    update();
  }
}
