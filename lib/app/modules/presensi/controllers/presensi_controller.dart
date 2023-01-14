import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/presensi/controllers/activity_controller.dart';
import 'package:iismee/app/modules/presensi/views/activity_view.dart';
import 'package:iismee/app/modules/presensi/views/presensi_view.dart';

class PresensiController extends GetxController {
  //TODO: Implement PresensiController

  RxInt selectedMenu = 0.obs;
  RxList<MenuPage> menuPages = [
    MenuPage(title: 'Sekarang'),
    MenuPage(title: 'Aktivitas', child: Container()),
    MenuPage(title: 'Riwayat', child: Container())
  ].obs;

  Rx<Widget> body = Container().obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<PageMenu> pageMenus = RxList([]);
  
  Rx<GlobalKey<NavigatorState>> presensiState = GlobalKey<NavigatorState>().obs;

  @override
  void onInit() {
    super.onInit();
    print('loaded');
    refreshMenu();
  }

  @override
  void onReady() {
    super.onReady();
    refreshMenu();
    

    Get.defaultDialog(
      navigatorKey: presensiState.value,
      backgroundColor: Colors.white,
      title: 'Perhatian',
      content: Column(
        children: [
          Text('Hari ini kamu belum absen, silahkan absen terlebih dahulu.', textAlign: TextAlign.center,),
          SizedBox(height: 20,),
          Text('(ketuk / klik mana saja untuk keluar)', style: TextStyle(color: Colors.black54),)
        ],
      ),
      // textConfirm: 'Tutup',
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  

  Widget getMenuPage({required SizeController sizeControl}){

    // // disposing the controller if exists

    if(Get.isRegistered<ActivityController>()){
      Get.delete<ActivityController>();
    }

    // Changing Presention's page

    switch (menuPages[selectedMenu.value].title) {
      case 'Sekarang':
        body = PresensiSekarang(sizeControl: sizeControl).obs;
        break;
      
      case 'Aktivitas':
        Get.put<ActivityController>(ActivityController());
        body = PresensiAktivitas(sizeControl: sizeControl).obs;
        break;
      default:
        body = Container().obs;
    }
    return body.value;
  }

  changePage(int index){
    selectedMenu = index.obs;
    print('selected menu is ' + menuPages[selectedMenu.value].title);
    refreshMenu();
    update();
  }

  refreshMenu(){
    pageMenus = List.generate(menuPages.length, (index) => PageMenu(
        title: menuPages[index].title, 
        isSelected: selectedMenu.value == index,
        onTap: (){
          changePage(index);
        },
      )).toList().obs;
  }
}

class MenuPage{
  final String title;
  final Widget? child;

  MenuPage({required this.title, this.child});
  
}