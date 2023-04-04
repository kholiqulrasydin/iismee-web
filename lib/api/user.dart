import 'package:get_storage/get_storage.dart';
import 'package:iismee/api/constant/api.dart';

class UserApi {
  static final storage = GetStorage();

  static Future<void> getUserData() async {
    Response res = await Api.get(routes: '/user/data');
    if (res.statusCode == 200) {
      storage.write('userData', res.data);
    }
  }
}
