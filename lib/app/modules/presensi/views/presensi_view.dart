import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/views/admin_layout/components/dashed_rect.dart';
// import 'package:iismee/app/views/admin_layout/responsive.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';
import 'package:iismee/app/views/components/colors.dart';
import 'package:intl/intl.dart';

import '../controllers/presensi_controller.dart';

// Text("- Add Activities"),
// Text("\n\n - Add Responsivable layout \n - Add Manage Events History \n - Add Search functions for Events and Their Histories")

class PresensiView extends GetView<PresensiController> {
  PresensiView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return GetBuilder<PresensiController>(builder: ((controller) {
      return MainAdminLayout(
        // appBarTitle: 'IISMEE Presensi',
        appBarAction: [
          SvgPicture.asset(
            'assets/icons/menu_notification.svg',
            color: Colors.blueGrey,
            height: 20,
          )
        ],
        body: Column(
          crossAxisAlignment: sizeControl.isLargeScreen.value
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            if (sizeControl.isLargeScreen.value)
              SizedBox(height: sizeControl.getHeightFromPrecentage(2)),
            Container(
              margin:
                  EdgeInsets.only(top: sizeControl.getHeightFromPrecentage(1)),
              height: 50,
              child: !sizeControl.isLargeScreen.value
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: sizeControl.getWidthFromPrecentage(5),
                              right: sizeControl.getWidthFromPrecentage(10)),
                          child: Text(
                            'Presensi',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey.shade700),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                children: controller.pageMenus,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: sizeControl.getWidthFromPrecentage(5)),
                        Text(
                          'Presensi',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey.shade700),
                        ),
                        SizedBox(width: sizeControl.getWidthFromPrecentage(18)),
                        Container(
                            margin: const EdgeInsets.only(top: 25),
                            width: sizeControl.getWidthFromPrecentage(20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: controller.pageMenus,
                              ),
                            )),
                        SearchWidget(sizeControl: sizeControl),
                        Container(
                          margin: EdgeInsets.only(
                              left: sizeControl.getWidthFromPrecentage(1)),
                          child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/icons/menu_notification.svg',
                              color: Colors.blueGrey,
                              height: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: sizeControl.getWidthFromPrecentage(1)),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert_rounded,
                              color: Colors.blueGrey,
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            controller.getMenuPage(sizeControl: sizeControl),
            const SizedBox(
              height: 20,
            )
          ],
        ),
        sizeControl: sizeControl,
      );
    }));
  }
}

class PresensiSekarang extends StatelessWidget {
  const PresensiSekarang({
    Key? key,
    required this.sizeControl,
  }) : super(key: key);

  final SizeController sizeControl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: sizeControl.isLargeScreen.value ? 40 : 10,
          left: sizeControl.getWidthFromPrecentage(5),
          right: sizeControl.getWidthFromPrecentage(5)),
      padding: EdgeInsets.symmetric(vertical: 20),
      width: sizeControl.getWidthFromPrecentage(90),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(-1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveRowToColumn(
            condition: sizeControl.isLargeScreen.value,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            columnMainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 400,
                width: sizeControl.getWidthFromPrecentage(
                    sizeControl.isLargeScreen.value ? 35 : 85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mulai Absen',
                      style: TextStyle(
                          color: Colors.blueGrey.shade600, fontSize: 25),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: sizeControl.getWidthFromPrecentage(
                              sizeControl.isLargeScreen.value ? 18 : 55),
                          child: Text(
                            'Apakah kamu menerapkan Keselamatan dan Kesehatan Kerja (K3) pada hari ini ?',
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(
                          width: sizeControl.getWidthFromPrecentage(
                              sizeControl.isLargeScreen.value ? 5 : 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(value: false, onChanged: (isK3) {}),
                              Text('Ya')
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: sizeControl.getWidthFromPrecentage(
                              sizeControl.isLargeScreen.value ? 18 : 55),
                          child: Text(
                            'Apakah kamu datang terlambat pada hari ini ?',
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(
                          width: sizeControl.getWidthFromPrecentage(
                              sizeControl.isLargeScreen.value ? 5 : 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(value: false, onChanged: (isK3) {}),
                              Text('Ya')
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Motivasi hari ini : '),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: sizeControl.getWidthFromPrecentage(
                          sizeControl.isLargeScreen.value ? 30 : 85),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2555)
                        ],
                        style: TextStyle(fontSize: 14),
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintMaxLines: 10,
                          hintStyle: TextStyle(fontSize: 14),
                          hintText: 'Tulis Motivasimu di sini .. ',
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              DropZoneFile(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 400,
                  height: 300,
                  body: Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        // BoxShadow(
                        //   color: Colors.grey.withOpacity(0.5),
                        //   spreadRadius: 4,
                        //   blurRadius: 10,
                        //   offset: const Offset(
                        //       2, 2), // changes position of shadow
                        // ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          color: Colors.blue,
                          minWidth: 200,
                          child: const Text(
                            'Upload Image',
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'or drop your image here',
                          style: TextStyle(color: Colors.blueGrey.shade700),
                        )
                      ],
                    ),
                  )),
            ],
          ),
          Container(
            alignment:
                sizeControl.isLargeScreen.value ? null : Alignment.center,
            margin: EdgeInsets.only(
                left: sizeControl.getWidthFromPrecentage(
                    sizeControl.isLargeScreen.value ? 10 : 10),
                right: sizeControl.getWidthFromPrecentage(
                  sizeControl.isLargeScreen.value ? 1 : 10,
                ),
                top: 10,
                bottom: 10),
            child: MaterialButton(
              onPressed: () {
                print('Start Presention');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              color: Colors.teal,
              minWidth: 200,
              child: const Text(
                'Saya Hadir',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveRowToColumn extends StatelessWidget {
  const ResponsiveRowToColumn(
      {super.key,
      required this.condition,
      required this.children,
      this.rowMainAxisAlignment,
      this.columnMainAxisAlignment,
      this.rowCrossAxisAlignment,
      this.columnCrossAxisAlignment});

  final bool condition;
  final List<Widget> children;
  final MainAxisAlignment? rowMainAxisAlignment;
  final MainAxisAlignment? columnMainAxisAlignment;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  final CrossAxisAlignment? columnCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return condition
        ? Row(
            mainAxisAlignment: rowMainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                rowCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: children,
          )
        : Column(
            mainAxisAlignment:
                columnMainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                columnCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: children,
          );
  }
}

class DropZoneFile extends StatefulWidget {
  DropZoneFile({
    super.key,
    required this.body,
    this.onHoverDropChild,
    this.onCreatedDropzoneViewController,
    this.onLoaded,
    this.onError,
    this.onHover,
    this.onDrop,
    this.onDropMultiple,
    this.onLeave,
    this.width,
    this.height,
    this.margin,
    this.padding,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget body;
  final Widget? onHoverDropChild;
  DropzoneViewController? onCreatedDropzoneViewController;
  final Function()? onLoaded;
  final Function(String? ev)? onError;
  final Function()? onHover;
  final Function(dynamic item)? onDrop;
  final Function(List? items)? onDropMultiple;
  final Function()? onLeave;
  final double? width;
  final double? height;

  @override
  State<DropZoneFile> createState() => _DropZoneFileState();
}

class _DropZoneFileState extends State<DropZoneFile> {
  bool onHover = false;
  Widget onHoverWidget = const SizedBox();
  Widget body = const SizedBox();

  void hovered() {
    setState(() {
      onHover = true;
    });
    print('Dropzone has Hovered');
  }

  void leaved() {
    setState(() {
      onHover = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onHoverWidget = widget.onHoverDropChild ??
        Container(
          margin: widget.margin,
          width: widget.width ?? 400,
          height: widget.height ?? 400,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 4,
            //     blurRadius: 8,
            //     offset: const Offset(3, 3), // changes position of shadow
            //   ),
            // ],
          ),
          child: DashedRect(
            color: Colors.blueGrey.shade600,
            strokeWidth: 2.0,
            gap: 3.0,
            child: Center(
              child: Text('Drop Image Here'),
            ),
          ),
        );

    body = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      width: widget.width ?? 300,
      height: widget.height ?? 300,
      child: Stack(
        children: [
          onHover ? onHoverWidget : body,
          DropzoneView(
            operation: DragOperation.copy,
            cursor: onHover ? CursorType.grab : CursorType.Default,
            // onCreated: (DropzoneViewController dvController) => controller = ctrl,
            onCreated: (DropzoneViewController dvController) =>
                widget.onCreatedDropzoneViewController != null
                    ? widget.onCreatedDropzoneViewController = dvController
                    : {},
            onLoaded: widget.onLoaded,
            onError: widget.onError,
            onHover: () {
              widget.onHover == null ? print('') : widget.onHover!();
              hovered();
            },
            onDrop: widget.onDrop ?? (dynamic ev) => print('Drop: $ev'),
            onDropMultiple: widget.onDropMultiple ??
                (List<dynamic>? ev) =>
                    print('Drop multiple: ${ev ?? 'no items'}'),
            onLeave: () {
              widget.onLeave == null ? print('') : widget.onLeave!();
              leaved();
            },
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.sizeControl,
  }) : super(key: key);

  final SizeController sizeControl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(
          horizontal: sizeControl.getWidthFromPrecentage(1), vertical: 10),
      width: sizeControl.getWidthFromPrecentage(18),
      height: 50,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(-1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 45,
            width: sizeControl.getWidthFromPrecentage(14),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
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
          SvgPicture.asset(
            'assets/icons/Search.svg',
            color: Colors.blueGrey,
            height: 18,
          )
        ],
      ),
    );
  }
}

class PageMenu extends StatelessWidget {
  PageMenu(
      {Key? key,
      required this.title,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  final String title;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(title),
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 2,
              width: 50,
              decoration: BoxDecoration(
                  color: isSelected ? Colors.blueAccent.shade100 : primaryBackgroundColor,
                  borderRadius: BorderRadius.circular(15)),
            )
          ],
        ),
      ),
    );
  }
}
