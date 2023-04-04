import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:iismee/api/auth.dart';
import 'package:iismee/api/constant/firebase.dart';
import 'package:iismee/app/data/constants/theme.dart';
import 'package:iismee/app/modules/Login/controllers/login_controller.dart';
import 'package:iismee/app/modules/Login/views/login_view.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';
import 'package:iismee/wrapper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'app/controllers/size_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:iismee/app/views/admin_layout/controllers/MenuController.dart'
    as navMenu;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iismee/app/views/admin_layout/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  await GetStorage.init();
  initializeDateFormatting().then((_) => runApp(MainIismee()));
}

class MainIismee extends StatelessWidget {
  const MainIismee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IISMEE Dashboard',
        theme: ThemeData.light().copyWith(
          brightness: Brightness.light,
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          canvasColor: secondaryColor,
        ),
        home: MultiProvider(providers: [
          ChangeNotifierProvider(
            create: (context) => navMenu.MenuController(),
          ),
        ], child: Wrapper()));
  }
}
