import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/laporan/views/laporan_chats.dart';
import 'package:iismee/app/modules/presensi/views/presensi_view.dart';
import 'package:iismee/app/views/admin_layout/components/responsive_layout.dart'
    as rsp;
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';
import 'package:pdfx/pdfx.dart';
import 'package:timelines/timelines.dart';

import '../controllers/laporan_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 'LaporanView is working \n - Add Laporan \n - Form \n\n - Laporan Status - Comments',

class LaporanView extends GetView<LaporanController> {
  LaporanView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return GetBuilder<LaporanController>(builder: (controller) {
      return MainAdminLayout(
          sizeControl: sizeControl,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: sizeControl.getWidthFromPrecentage(78),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Proposal',
                        style: TextStyle(
                            color: Colors.blueGrey.shade600, fontSize: 36),
                      ),
                      Text(
                        'IISMEE / Proposal',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: sizeControl.getWidthFromPrecentage(2),
                    vertical: 20),
                // padding: EdgeInsets.symmetric(horizontal: sizeControl.getWidthFromPrecentage(3), vertical: 10),
                width: sizeControl.getWidthFromPrecentage(80),
                child: ResponsiveRowToColumn(
                  condition: sizeControl.isLargeScreen.value,
                  rowMainAxisAlignment: MainAxisAlignment.start,
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 300,
                      height: 80,
                      margin: EdgeInsets.symmetric(
                          horizontal: sizeControl.getWidthFromPrecentage(0.8),
                          vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                -1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Status Proposal',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey.shade800),
                              ),
                              Text(
                                controller.isProposalExists
                                    ? 'Sudah diunggah'
                                    : 'Belum diunggah',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: controller.isProposalExists
                                        ? Colors.blue.shade800
                                        : Colors.red.shade800),
                              ),
                              Row(
                                children: [
                                  Text('terakhir diperbarui : ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey.shade800)),
                                  Text('Sekarang',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.teal.shade800)),
                                ],
                              )
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/icons/pdf_file.svg',
                            height: 40,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 80,
                      margin: EdgeInsets.symmetric(
                          horizontal: sizeControl.getWidthFromPrecentage(0.8),
                          vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                -1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Simpan Proposal',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey.shade800),
                              ),
                              Text(
                                controller.isProposalSaved
                                    ? 'Sudah disimpan'
                                    : 'Belum disimpan',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: controller.isProposalSaved
                                        ? Colors.blue.shade800
                                        : Colors.red.shade800),
                              ),
                              Row(
                                children: [
                                  Text('terakhir diperbarui : ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey.shade800)),
                                  Text('Sekarang',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.teal.shade800)),
                                ],
                              )
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/icons/pdf_file.svg',
                            height: 40,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 80,
                      margin: EdgeInsets.symmetric(
                          horizontal: sizeControl.getWidthFromPrecentage(0.8),
                          vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                -1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Penilaian Proposal',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey.shade800),
                              ),
                              Text(
                                'Belum dinilai',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.red.shade800),
                              ),
                              Row(
                                children: [
                                  Text('terakhir diperbarui : ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey.shade800)),
                                  Text('Sekarang',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.teal.shade800)),
                                ],
                              )
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/icons/pdf_file.svg',
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: sizeControl.getWidthFromPrecentage(2),
                    vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: sizeControl.getWidthFromPrecentage(25),
                      height: 500,
                      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                -1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: IismeeChats(),
                      ),
                    ),
                    Container(
                        width: sizeControl.getWidthFromPrecentage(50),
                        height: 500,
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(
                                  -1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: controller.progressList == null ||
                                controller.progressList!.isEmpty
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        sizeControl.getWidthFromPrecentage(48),
                                    height: 140,
                                    child: Timeline.tileBuilder(
                                      theme: TimelineThemeData(
                                        direction: Axis.horizontal,
                                        connectorTheme: ConnectorThemeData(
                                          space: 30.0,
                                          thickness: 5.0,
                                        ),
                                      ),
                                      builder: TimelineTileBuilder.connected(
                                        connectionDirection:
                                            ConnectionDirection.before,
                                        itemExtentBuilder: (_, __) =>
                                            sizeControl
                                                .getWidthFromPrecentage(10),
                                        // MediaQuery.of(context).size.width /
                                        // _processes.length,
                                        oppositeContentsBuilder:
                                            (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0),
                                              child: IconButton(
                                                onPressed: () {
                                                  if (index > 0) {
                                                    controller
                                                        .changeForm(index);
                                                  }
                                                },
                                                icon: Icon(controller
                                                        .progressList![index]
                                                    ['icon']),
                                                color:
                                                    controller.getColor(index),
                                              ));
                                        },
                                        contentsBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Text(
                                              controller.progressList![index]
                                                  ['title'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    controller.getColor(index),
                                              ),
                                            ),
                                          );
                                        },
                                        indicatorBuilder: (_, index) {
                                          print(index ==
                                              controller.processIndex.value);
                                          var color;
                                          var child;
                                          if (index ==
                                              controller.processIndex.value) {
                                            color = inProgressColor;
                                            child = const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3.0,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white),
                                              ),
                                            );
                                          } else if (index <
                                              controller.processIndex.value) {
                                            color = completeColor;
                                            child = Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 15.0,
                                            );
                                          } else {
                                            color = todoColor;
                                          }

                                          if (index <=
                                              controller.processIndex.value) {
                                            return Stack(
                                              children: [
                                                CustomPaint(
                                                  size: Size(30.0, 30.0),
                                                  painter: _BezierPainter(
                                                    color: color,
                                                    drawStart: index > 0,
                                                    drawEnd: index <
                                                        controller
                                                            .processIndex.value,
                                                  ),
                                                ),
                                                DotIndicator(
                                                  size: 30.0,
                                                  color: color,
                                                  child: child,
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Stack(
                                              children: [
                                                CustomPaint(
                                                  size: Size(15.0, 15.0),
                                                  painter: _BezierPainter(
                                                    color: color,
                                                    drawEnd: index <
                                                        _processes.length - 1,
                                                  ),
                                                ),
                                                OutlinedDotIndicator(
                                                  borderWidth: 4.0,
                                                  color: color,
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                        connectorBuilder: (_, index, type) {
                                          if (index > 0) {
                                            if (index ==
                                                controller.processIndex.value) {
                                              final prevColor = controller
                                                  .getColor(index - 1);
                                              final color =
                                                  controller.getColor(index);
                                              List<Color> gradientColors;
                                              if (type == ConnectorType.start) {
                                                gradientColors = [
                                                  Color.lerp(
                                                      prevColor, color, 0.5)!,
                                                  color
                                                ];
                                              } else {
                                                gradientColors = [
                                                  prevColor,
                                                  Color.lerp(
                                                      prevColor, color, 0.5)!
                                                ];
                                              }
                                              return DecoratedLineConnector(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: gradientColors,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return SolidLineConnector(
                                                color:
                                                    controller.getColor(index),
                                              );
                                            }
                                          } else {
                                            return null;
                                          }
                                        },
                                        itemCount:
                                            controller.progressList!.length,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizeControl
                                            .getWidthFromPrecentage(10),
                                        vertical: 20),
                                    height: 300,
                                    child: controller.progressList![
                                        controller.selectedPage.value]['body'],
                                  )
                                ],
                              ))
                  ],
                ),
              )
            ],
          ));
    });
  }
}

class KelengkapanBerkas extends StatelessWidget {
  KelengkapanBerkas({super.key});
  final sizeControl = Get.find<SizeController>();
  final controller = Get.find<LaporanController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporanController>(builder: (context) {
      return Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: sizeControl.getWidthFromPrecentage(
                    sizeControl.isLargeScreen.value ? 18 : 55),
                child: Text(
                  'Apakah Proposalmu memuat latar belakang?',
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                width: sizeControl.getWidthFromPrecentage(
                    sizeControl.isLargeScreen.value ? 5 : 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Checkbox(
                        value: controller.latarBelakang.value,
                        onChanged: (val) {
                          controller.latarBelakangOnChange(val!);
                        }),
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
                  'Apakah proposalmu memuat Tujuan?',
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                width: sizeControl.getWidthFromPrecentage(
                    sizeControl.isLargeScreen.value ? 5 : 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Checkbox(
                        value: controller.tujuan.value,
                        onChanged: (val) {
                          controller.tujuanOnChange(val!);
                        }),
                    Text('Ya')
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              controller.saveData();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            color: Colors.teal,
            minWidth: 200,
            child: controller.onAsync.value == true
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
          ),
        ],
      );
    });
  }
}

class PdfViewerScreen extends StatefulWidget {
  final Uint8List bytes;

  PdfViewerScreen({Key? key, required this.bytes}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PdfController? docController;

  void opendata() async {
    setState(() {
      docController =
          PdfController(document: PdfDocument.openData(widget.bytes));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opendata();
  }

  @override
  Widget build(BuildContext context) {
    return docController == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : PdfView(
            controller: docController!,
            renderer: (PdfPage page) => page.render(
              width: page.width * 2,
              height: page.height * 2,
              format: PdfPageImageFormat.jpeg,
              backgroundColor: '#FFFFFF',
            ),
          );
  }
}

class UploadFile extends StatefulWidget {
  UploadFile({super.key, required this.sizeControl});

  final SizeController sizeControl;

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  final controller = Get.find<LaporanController>();
  final sizeControl = Get.find<SizeController>();

  DropzoneViewController? dropzoneViewController;
  void onFileSelected(dynamic file, LaporanController) async {
    if (file is File) {
      controller.filePdf = (await file.readAsBytes()).obs;
      setState(() {});
      // Do something with the selected file on Android and desktop
    } else if (file is Uint8List) {
      setState(() {
        controller.filePdf = file.obs;
      });
      // Do something with the selected file on the web
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporanController>(builder: (controller) {
      return controller.filePdf != null
          ? Row(
              children: [
                Container(
                  width: 100,
                  height: 350,
                  child: PdfViewerScreen(bytes: controller.filePdf!.value),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.symmetric(
                      horizontal: sizeControl.getWidthFromPrecentage(5),
                      vertical: 45),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    onPressed: controller.nextForm,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.teal,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                DropZoneFile(
                    onCreatedDropzoneViewController: dropzoneViewController,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 400,
                    height: 300,
                    body: Container(
                      width: 400,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [],
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            'or drop your pdf here',
                            style: TextStyle(color: Colors.blueGrey.shade700),
                          )
                        ],
                      ),
                    )),
                Positioned(
                  top: 100,
                  child: MaterialButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf']);
                      if (result != null) {
                        if (kIsWeb) {
                          Uint8List bytes = result.files.single.bytes!;
                          onFileSelected(bytes, controller);
                        } else if (Platform.isAndroid ||
                            (Platform.isWindows ||
                                Platform.isLinux ||
                                Platform.isMacOS)) {
                          File file = File(result.files.single.path!);
                          onFileSelected(file, controller);
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    color: Colors.blue,
                    minWidth: 200,
                    child: const Text(
                      'Upload file',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                )
              ],
            );
    });
  }
}

class LaporanForm extends StatelessWidget {
  LaporanForm({Key? key, required this.sizeControl}) : super(key: key);

  final SizeController sizeControl;
  final controller = Get.find<LaporanController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporanController>(builder: (controller) {
      return Column(
        children: [
          SizedBox(
            height: 50,
            // width: sizeControl.getWidthFromPrecentage(30),
            child: TextFormField(
              onChanged: controller.judulOnChange,
              decoration: InputDecoration(
                label: Text('Judul Proposal'),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.blueGrey.shade600,
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 50,
            // width: sizeControl.getWidthFromPrecentage(30),
            child: TextFormField(
              onChanged: controller.temaOnChange,
              decoration: InputDecoration(
                label: Text('Tema'),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.blueGrey.shade600,
                    )),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.symmetric(
                horizontal: sizeControl.getWidthFromPrecentage(5),
                vertical: 45),
            child: MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              onPressed: controller.nextForm,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: Colors.teal,
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      );
    });
  }
}

/// hardcoded bezier painter
/// TODO: Bezier curve into package component
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'Prospect',
  'Tour',
  'Offer',
  'Contract',
  'Settled',
];
