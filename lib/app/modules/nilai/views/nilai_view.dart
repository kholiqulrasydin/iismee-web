import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';

import '../controllers/nilai_controller.dart';

class NilaiView extends GetView<NilaiController> {
  NilaiView({Key? key}) : super(key: key);

  final sizeControl = Get.find<SizeController>();
  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return GetBuilder<NilaiController>(builder: (controller) {
      return MainAdminLayout(
        sizeControl: sizeControl,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: sizeControl.getWidthFromPrecentage(2)),
                    width: sizeControl.getWidthFromPrecentage(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nilai',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade600,
                                  fontSize: 36),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'IISMEE / Nilai',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  width: sizeControl.getWidthFromPrecentage(40),
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.menuPages.isEmpty
                          ? [Container()]
                          : controller.menuPages,
                    ),
                  ),
                ),
              ],
            ),
            !controller.hasScore.value
                ? Container(
                    width: sizeControl.getWidthFromPrecentage(80),
                    height: 800,
                    alignment: Alignment.center,
                    child: Text(
                      "Laporanmu belum dinilai oleh dosen pembimbing atau mentor magangmu.",
                      style: TextStyle(color: Colors.blueGrey.shade600),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}
