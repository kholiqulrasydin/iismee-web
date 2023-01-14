import 'package:get/get.dart';

import '../controllers/participant_score_controller.dart';

class ParticipantScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipantScoreController>(
      () => ParticipantScoreController(),
    );
  }
}
