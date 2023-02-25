import 'package:get/get.dart';

import '../controllers/presensi_mahasiswa_controller.dart';

class PresensiMahasiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresensiMahasiswaController>(
      () => PresensiMahasiswaController(),
    );
  }
}
