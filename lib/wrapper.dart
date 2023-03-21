import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iismee/api/auth.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/data/constants/theme.dart';
import 'package:iismee/app/modules/Login/controllers/login_controller.dart';
import 'package:iismee/app/modules/Login/views/login_view.dart';
import 'package:iismee/app/routes/app_pages.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:iismee/app/views/admin_layout/controllers/MenuController.dart'
    as navMenu;

class Wrapper extends StatefulWidget {
  Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<navMenu.MenuController>().fToast = FToast();
    context.read<navMenu.MenuController>().fToast!.init(context);
    // Authenticator.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: Authenticator.getToken(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return Scaffold(
    //           backgroundColor: Colors.white,
    //           body: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //       }
    //       return MainScreen(isLoggedIn: snapshot.data != null);
    //     });

    return Consumer<navMenu.MenuController>(
        builder: (context, menuController, _) {
      return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            String? token = Authenticator.storage.read('token');
            Map<String, dynamic>? userData =
                Authenticator.storage.read('userData');
            int? role = Authenticator.storage.read('role');
            print('Logged in : ' + snapshot.hasData.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Splash();
            }
            if (snapshot.data == null) {
              return LoginWrapper();
            }
            if (snapshot.data != null && token != null && token.length > 5) {
              print(userData!['name']);
              menuController.role = role!;
              print('Entering Dashboard ... ');
              // Authenticator.showToast(
              //     'Selamat datang kembali ${userData["name"]}',
              //     false,
              //     menuController.fToast!);
              menuController.buildPages();
              return MainScreen();
            }
            if (snapshot.data != null && token == null) {
              return LoginWrapper();
            }
            return Splash();
          });
    });
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Colors.white,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: BindingsBuilder(() {
        // Get.put(SizeController());
        Get.lazyPut<SizeController>(
          () => SizeController(),
        );
        // add more bindings in here
      }),
      initialRoute: AppPages.routes.first.name,
      getPages: AppPages.routes,
    );
  }
}
