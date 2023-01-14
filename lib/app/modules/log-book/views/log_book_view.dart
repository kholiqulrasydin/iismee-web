import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/log_book_controller.dart';

class LogBookView extends GetView<LogBookController> {
  const LogBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogBookView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LogBookView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
