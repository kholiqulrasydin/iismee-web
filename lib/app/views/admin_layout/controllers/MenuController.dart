import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iismee/app/routes/app_pages.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int selectedDrawerItem = 0;
  int role = 99;
  FToast? fToast;
  List<GetPage> pages = [];

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void keyDispose() {
    _scaffoldKey.currentState!.dispose();
  }

  void buildPages() {
    print('building page .. ');
    switch (role) {
      case 99:
        pages = AppPages.routes
            .where((element) => element.name == 'login')
            .toList();
        break;
      case 1:
        pages = AppPages.routes
            .where((element) => element.title!.contains('dosen'))
            .toList();
        break;
      case 2:
        pages = AppPages.routes
            .where((element) =>
                !element.title!.contains('dosen') && element.title! != 'login')
            .toList();
        break;
      default:
    }
    if (pages.isNotEmpty) {
      print('pages has built successfully');
    }
    print(pages.length.toString() + ' total pages');
  }
}
