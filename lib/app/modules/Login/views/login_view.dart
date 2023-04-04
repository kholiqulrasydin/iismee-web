import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:html' as html;

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iismee/api/auth.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';
import 'package:iismee/wrapper.dart';
import 'package:provider/provider.dart';

import '../controllers/login_controller.dart';
import 'package:iismee/app/views/admin_layout/controllers/MenuController.dart'
    as navMenu;

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: sizeControl.getWidthFromPrecentage(10),
              vertical: sizeControl.getWidthFromPrecentage(5)),
          child: Container(
            width: sizeControl.getWidthFromPrecentage(80),
            height: sizeControl.getHeightFromPrecentage(90),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoginForm(sizeControl: sizeControl),
                if (MediaQuery.of(context).orientation ==
                        Orientation.landscape &&
                    sizeControl.getDifferencePrecentage(
                            sizeControl.width.value, sizeControl.height.value) >
                        20)
                  LoginRightSide(sizeControl: sizeControl)
              ],
            ),
          ),
        ));
  }
}

class LoginRightSide extends StatelessWidget {
  const LoginRightSide({
    Key? key,
    required this.sizeControl,
  }) : super(key: key);

  final SizeController sizeControl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeControl.getWidthFromPrecentage(40),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 245, 248),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo-unesa.png',
            width: sizeControl.getWidthFromPrecentage(25),
            height: sizeControl.getWidthFromPrecentage(25),
          ),
          // SizedBox(height: sizeControl.getHeightFromPrecentage(0.2),),
          Text(
            'Internship Information System of Mechanical Engineering Education (IISMEE)',
            style: TextStyle(
                color: Colors.blue.shade800, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.sizeControl,
  }) : super(key: key);

  final SizeController sizeControl;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  void obscured() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.sizeControl.getWidthFromPrecentage(4)),
      width: widget.sizeControl.getWidthFromPrecentage(
          MediaQuery.of(context).orientation == Orientation.landscape &&
                  widget.sizeControl.getDifferencePrecentage(
                          widget.sizeControl.width.value,
                          widget.sizeControl.height.value) >
                      20
              ? 40
              : 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            MediaQuery.of(context).orientation == Orientation.landscape &&
                    widget.sizeControl.getDifferencePrecentage(
                            widget.sizeControl.width.value,
                            widget.sizeControl.height.value) >
                        20
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
        children: [
          if (MediaQuery.of(context).orientation == Orientation.portrait)
            Image.asset(
              'assets/logo-unesa.png',
              width: widget.sizeControl.getWidthFromPrecentage(25),
              height: widget.sizeControl.getWidthFromPrecentage(25),
            ),
          SizedBox(
            height: widget.sizeControl.getHeightFromPrecentage(1),
          ),
          Text(
            'Login IISMEE',
            style: TextStyle(color: Colors.blue, fontSize: 24),
          ),
          SizedBox(
            height: widget.sizeControl.getHeightFromPrecentage(5),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: 'Email', hintText: 'example : username@email.com'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {});
            },
          ),
          SizedBox(
            height: widget.sizeControl.getHeightFromPrecentage(2),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'your secret password',
                suffixIcon: IconButton(
                    tooltip: 'show password',
                    onPressed: obscured,
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: isObscure ? Colors.blueGrey : Colors.blue,
                    ))),
            obscureText: isObscure,
            onChanged: (value) {
              setState(() {});
            },
          ),
          SizedBox(
            height: widget.sizeControl.getHeightFromPrecentage(4),
          ),
          MaterialButton(
            onPressed: () {},
            minWidth: widget.sizeControl.getWidthFromPrecentage(
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 40
                    : 70),
            color: (emailController.text.isNotEmpty &&
                    passwordController.text.length > 5)
                ? Colors.blue
                : Colors.blueGrey,
            child: Text(
              'Mulai Masuk',
            ),
            textColor: Colors.white,
            height: widget.sizeControl.getHeightFromPrecentage(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          SizedBox(
            height: widget.sizeControl.getHeightFromPrecentage(5),
          ),
          Row(children: <Widget>[
            Expanded(child: Divider()),
            Text(" ATAU "),
            Expanded(child: Divider()),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login Menggunakan : '),
              Container(
                width: 80,
                margin: EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<navMenu.MenuController>(
                        builder: (context, menuController, _) {
                      return GestureDetector(
                        onTap: () async {
                          User? account =
                              await Authenticator.signInWithGoogle();
                          FToast fToast =
                              context.read<navMenu.MenuController>().fToast!;
                          if (account != null) {
                            print(account.displayName);
                            int role = await Authenticator.setToken(
                                account.email!, account.uid, fToast);
                            print('setting role into ' + role.toString());
                            menuController.role = role;
                            menuController.buildPages();
                            html.window.location.reload();
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //         builder: ((context) => Wrapper())));
                            // context.read<navMenu.MenuController>().role = role;

                            // context.read<navMenu.MenuController>().buildPages();
                          }
                        },
                        child: Image.asset(
                          'assets/google.png',
                          width: 25,
                        ),
                      );
                    }),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.phone,
                          color: Colors.blueGrey,
                        )),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
