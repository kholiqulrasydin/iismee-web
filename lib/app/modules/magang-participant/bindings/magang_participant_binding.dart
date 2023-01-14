import 'package:get/get.dart';

import '../controllers/magang_participant_controller.dart';

class MagangParticipantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MagangParticipantController>(
      () => MagangParticipantController(),
    );
  }
}
