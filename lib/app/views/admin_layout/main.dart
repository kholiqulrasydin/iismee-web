import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iismee/app/views/admin_layout/constants.dart';
import 'package:iismee/app/views/admin_layout/controllers/MenuController.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';
import 'package:provider/provider.dart';

class AdminLayout extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IISMEE Dashboard',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
