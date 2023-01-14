import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeController extends GetxController {
  late Rx<BuildContext> rxContext;
  RxDouble height = (.0).obs;
  RxDouble width = (.0).obs;
  RxBool isLargeScreen = false.obs;
  RxBool isTabScreen = false.obs;
  RxBool isMobileScreen = false.obs;
  Rx<Orientation> orientation = Orientation.landscape.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  double getHeightFromPrecentage(double precentage) {
    return precentage / 100 * height.value;
  }

  double getWidthFromPrecentage(double precentage) {
    return precentage / 100 * width.value;
  }

  double getDifferencePrecentage(double screenWidth, double screenHeight) {
    // print((100 *
    //         ((screenWidth - screenHeight) / ((screenWidth + screenHeight) / 2)))
    //     .toString());
    return 100 *
        ((screenWidth - screenHeight) / ((screenWidth + screenHeight) / 2));
  }

  createSize(BuildContext context) {
    rxContext = context.obs;
    Size size = MediaQuery.of(rxContext.value).size;
    height = size.height.obs;
    width = size.width.obs;
    orientation = context.orientation.obs;
    print("Device Pixel Ratio : ${rxContext.value.devicePixelRatio}");
    isLargeScreen = (height.value < width.value &&
        getDifferencePrecentage(width.value, height.value) > 50 && width > 1280)
        .obs;

    isTabScreen = (getDifferencePrecentage(width.value, height.value) < 50 &&
        getDifferencePrecentage(width.value, height.value) > -50)
        .obs;

    isMobileScreen = (width.value < height.value &&
        getDifferencePrecentage(width.value, height.value) < -50)
        .obs;

    print(isLargeScreen.value
        ? 'This is Desktop'
        : isTabScreen.value
        ? 'This is tab'
        : isMobileScreen.value
        ? 'This is Mobile Screen'
        : 'is it Tab Screen ?');
  }
}
