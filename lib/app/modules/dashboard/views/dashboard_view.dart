import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();
  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return MainAdminLayout(
      body: Center(
        child: Text(
          'DashboardView is working \n\n - Notification Panel \n - Presention Calendar \n - Last Proposal / Laporan Comments \n - Presention Score \n - Proposal / Laporan Score \n - Magang Profile',
          style: TextStyle(fontSize: 20),
        ),
      ), 
      sizeControl: sizeControl,
    );
  }
}
