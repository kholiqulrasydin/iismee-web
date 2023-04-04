import 'package:get/get.dart';
import 'package:iismee/api/user.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  final count = 0.obs;
  Rx<Map<String, dynamic>>? userData;

  onInitData() {
    userData = Rx(UserApi.storage.read('userData') as Map<String, dynamic>);
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    onInitData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
