import 'package:get/get.dart';

import '../controllers/dosen_dashboard_controller.dart';

class DosenDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DosenDashboardController>(
      () => DosenDashboardController(),
    );
  }
}
