import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iismee/api/constant/api.dart';
import 'package:iismee/api/user.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:iismee/app/views/admin_layout/controllers/MenuController.dart'
    as navMenu;
import 'dart:html' as html;

class Authenticator {
  static final storage = GetStorage();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  // static GoogleSignIn _googleSignIn = GoogleSignIn(
  //   clientId:
  //       '140501555057-qjectgodu09mkona0mc12pe8kb2rs5h9.apps.googleusercontent.com',
  //   // scopes: [
  //   //   'email',
  //   //   'https://www.googleapis.com/auth/contacts.readonly',
  //   // ],
  // );

  static void showToast(String messages, bool alert, FToast fToast) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: alert ? Colors.amber : Colors.teal,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            alert ? Icons.warning_amber_outlined : Icons.check,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            messages,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: const Duration(seconds: 2),
    );
  }

  static Future<User?> signInWithGoogle() async {
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    // Obtain the auth details from the request
    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);
      print(userCredential.user!.uid);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut().then((value) {
      storage.erase();
      html.window.location.reload();
    });
  }

  static Future<String?> getToken() async {
    try {
      return storage.read('token');
    } catch (e) {
      return null;
    }
  }

  static Future<int> setToken(String email, String gId, FToast fToast) async {
    print(email);
    Response getToken = await Api.postOnce(
        routes: '/login', data: {'email': email, 'g_id': gId});
    int role = 99;
    if (getToken.statusCode == 200) {
      storage.write('token', getToken.data!['accessToken']);
      storage.write('userData', getToken.data!['userData']);
      print('got role 5');
      switch (getToken.data!['userData']["role_id"] as int) {
        case 5:
          role = 2;
          break;
        case 3:
          role = 1;
          break;
        case 4:
          role = 88;
          break;
        default:
      }
      storage.write('role', role);
      await UserApi.getUserData();
      showToast('Selamat datang ${getToken.data!["userData"]["name"]}', false,
          fToast);
    } else {
      showToast('Login gagal, silahkan ulangi lagi', true, fToast);
    }
    return role;
  }
}

class AuthResponse {
  final GoogleSignInAccount? userData;
  final String? errorMsg;
  final int responseCode;

  AuthResponse({this.userData, this.errorMsg, required this.responseCode});
}
