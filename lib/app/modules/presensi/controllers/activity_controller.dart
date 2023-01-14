import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityController extends GetxController {
  //TODO: Implement LaporanController
  RxList<CalendarEventData> presentionEvents =[
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
  
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if(monthViewKey.value.currentState != null){
      monthViewKey.value.currentState!.animateToMonth(DateTime.now());
      eventController.value.addAll(presentionEvents);
    }
  }

  @override
  void onClose() {
    super.onClose();
    eventController.value.dispose();
    if(monthViewKey.value.currentState != null){
      monthViewKey.value.currentState!.dispose();
      print('Activity Presention is Disposed .. ');
      print('Leaving now');
    }
  }

  openCloseMonthSelector(){
    onMonthSelection.value ? onMonthSelection = false.obs : onMonthSelection = true.obs;
    update();
  }
}
