import 'package:get/get.dart';

import '../controllers/log_book_controller.dart';

class LogBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogBookController>(
      () => LogBookController(),
    );
  }
}
