import 'package:get/get.dart';
import 'package:iismee/app/modules/participant-score/views/participant_score_view.dart';

class NilaiController extends GetxController {
  //TODO: Implement NilaiController

  RxList<PageMenu> menuPages = RxList([]);
  RxList<String> mpk =
      ['Perencanaan Program', 'Pelaksanaan Program', 'Pelaporan Program'].obs;
  RxInt selectedMpk = 0.obs;
  RxBool hasScore = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    buildPageMenu();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectMpk(int index) {
    selectedMpk = index.obs;
    buildPageMenu();
    update();
  }

  void buildPageMenu() {
    menuPages = List.generate(mpk.length, (index) {
      return PageMenu(
          title: 'MPK ' + mpk[index],
          isSelected: selectedMpk.value == index,
          onTap: () {
            selectMpk(index);
          });
    }).toList().obs;
    update();
  }
}
