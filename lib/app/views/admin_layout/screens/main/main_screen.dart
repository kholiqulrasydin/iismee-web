import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/data/constants/theme.dart';
import 'package:iismee/app/modules/Login/controllers/login_controller.dart';
import 'package:iismee/app/modules/Login/views/login_view.dart';
import 'package:iismee/app/modules/laporan/controllers/laporan_controller.dart';
import 'package:iismee/app/modules/participant-score/controllers/participant_score_controller.dart';
import 'package:iismee/app/modules/presensi/controllers/presensi_controller.dart';
import 'package:iismee/app/modules/presensi/views/presensi_view.dart';
import 'package:iismee/app/routes/app_pages.dart';
import 'package:iismee/app/views/admin_layout/constants.dart';
import 'package:iismee/app/views/admin_layout/controllers/MenuController.dart';
import 'package:iismee/app/views/admin_layout/responsive.dart';
import 'package:iismee/app/views/admin_layout/screens/main/components/drawer_menu.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      key: context.read<MenuController>().scaffoldKey,
      drawer: Drawer(backgroundColor: Colors.blue, child: SideMenu()),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: context.read<MenuController>().role == 99 ? 
        GetMaterialApp(
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
                  ) : Stack(
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Positioned(
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.blue,
                  )),
            Container(
                width: MediaQuery.of(context).size.width * 0.18,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(15))),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.18,
                    child: SideMenu())),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                left: 5,
                child: ProfileCard()),
            Positioned(
              right: MediaQuery.of(context).size.width *
                  (Responsive.isDesktop(context) ? 0 : 0),
              top: MediaQuery.of(context).size.height *
                  (Responsive.isDesktop(context) ? 0.02 : 0),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    (Responsive.isDesktop(context) ? 0.82 : 1),
                height: MediaQuery.of(context).size.height *
                    (Responsive.isDesktop(context) ? 0.98 : 1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(15))
                    // borderRadius: BorderRadius.circular((Responsive.isDesktop(context) ? 15 : 0)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 3,
                    //     blurRadius: 5,
                    //     offset: Offset(0, 3), // changes position of shadow
                    //   ),
                    // ],
                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      (Responsive.isDesktop(context) ? 15 : 0)),
                  child: GetMaterialApp(
                    color: Colors.white,
                    theme: lightTheme,
                    darkTheme: darkTheme,
                    themeMode: ThemeMode.system,
                    initialBinding: BindingsBuilder(() {
                      Get.lazyPut<SizeController>(
                        () => SizeController(),
                      );

                      Get.lazyPut<PresensiController>(
                        () => PresensiController(),
                      );

                      Get.lazyPut<LaporanController>(
                        () => LaporanController(),
                      );

                      Get.lazyPut<ParticipantScoreController>(
                        () => ParticipantScoreController(),
                      );
                      // add more bindings in here
                    }),
                    initialRoute: context.read<MenuController>().role > 1 ? AppPages.routes[context.read<MenuController>().selectedDrawerItem + 1].name : AppPages.routes.where((element) => element.title!.split('_')[0] == 'dosen').toList()[context.read<MenuController>().selectedDrawerItem].name,
                    getPages: context.read<MenuController>().role > 1 ? AppPages.routes : AppPages.routes.where((element) => element.title!.split('_')[0] == 'dosen').toList()
                  ),
                ),
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.vertical,
                //   primary: false,
                //   padding: EdgeInsets.all(defaultPadding),
                //   child: Column(
                //     children: [
                //       // Header(),
                //       // SizedBox(height: defaultPadding),
                //       GetMaterialApp(
                //         theme: lightTheme,
                //         darkTheme: darkTheme,
                //         themeMode: ThemeMode.system,
                //         initialBinding: BindingsBuilder(() {

                //           Get.lazyPut<SizeController>(
                //                 () => SizeController(),
                //           );
                //           // add more bindings in here

                //         }),
                //         initialRoute: Routes.DASHBOARD,
                //         getPages: AppPages.routes,
                //       )
                //     ],
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainAdminLayout extends StatelessWidget {
  final String? appBarTitle;
  final List<Widget>? appBarAction;
  final Widget body;
  final Widget? appBarWidget;
  final SizeController sizeControl;

  const MainAdminLayout(
      {super.key,
      required this.body,
      this.appBarTitle,
      this.appBarAction,
      this.appBarWidget,
      required this.sizeControl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(252, 242, 242, 255),
      // appBar: !Responsive.isDesktop(context) ? AppBar(
      //   foregroundColor: Colors.blueGrey.shade800,
      //   elevation: 0,
      //   title: appBarTitle != null ? Center(child: Text(appBarTitle!)) : ,
      //   backgroundColor: Colors.white,
      // ) : null,
      body: sizeControl.isLargeScreen.value
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()
                  ),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    body,
                    SizedBox(height: 50,),
                    Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/flutter-logo.png', height: 20,),
                              SizedBox(width: 20,),
                              Text("Made With Love - Vokasi UNESA "),
                              SizedBox(width: 20,),
                              Image.asset('assets/logo-unesa.png', height: 20,)
                            ]
                            ),
                            
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                Container(
                  height: sizeControl.height.value,
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()
                  ),
                  scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: body
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/flutter-logo.png', height: 20,),
                              SizedBox(width: 20,),
                            Text("Made With Love - Vokasi UNESA "),
                              SizedBox(width: 20,),
                            Image.asset('assets/logo-unesa.png', height: 20,)
                          ]
                          ),
                        
                    SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: AppBarSearchWidget(
                    sizeControl: sizeControl,
                    appBarAction: [
                      ...appBarAction ?? [],
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/images/profile_pic.png",
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class AppBarSearchWidget extends StatelessWidget {
  const AppBarSearchWidget(
      {Key? key, required this.sizeControl, this.appBarAction, this.leading})
      : super(key: key);

  final SizeController sizeControl;
  final List<Widget>? appBarAction;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: sizeControl.getWidthFromPrecentage(5)),
      padding: EdgeInsets.symmetric(
          horizontal: sizeControl.getWidthFromPrecentage(5), vertical: 5),
      width: sizeControl.getWidthFromPrecentage(90),
      height: 40,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: context.read<MenuController>().controlMenu,
              icon: Icon(Icons.menu_rounded)),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: SizedBox(
              height: 38,
              width: sizeControl.getWidthFromPrecentage(50),
              child: TextField(
                inputFormatters: [LengthLimitingTextInputFormatter(23)],
                style: TextStyle(fontSize: 18),
                maxLines: 1,
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintStyle: TextStyle(fontSize: 18),
                  hintText: 'Cari',
                  border: InputBorder.none,
                ),
                onSubmitted: (String value) async {
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Thanks!'),
                        content: Text(
                            'You typed "$value". \n This Widget is on going'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/icons/Search.svg',
            color: Colors.blueGrey,
            height: 18,
          ),
          ...appBarAction ?? []
        ],
      ),
    );
  }
}
