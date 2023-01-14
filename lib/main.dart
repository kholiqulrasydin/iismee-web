import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:iismee/app/data/constants/theme.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/controllers/size_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/views/admin_layout/main.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // FirebaseApp app = await Firebase.initializeApp(options: firebaseConfig);
  await GetStorage.init();
  initializeDateFormatting().then((_) => runApp(AdminLayout()));
}

class MainIismee extends StatelessWidget {
  const MainIismee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminLayout()
      );
  }
}
