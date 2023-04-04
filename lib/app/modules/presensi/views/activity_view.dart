import 'package:calendar_view/calendar_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/presensi/controllers/activity_controller.dart';
import 'package:iismee/app/modules/presensi/views/presensi_view.dart';
import 'package:iismee/app/views/admin_layout/components/dashed_rect.dart';
import 'package:intl/intl.dart';

class PresensiAktivitas extends GetView<ActivityController> {
  const PresensiAktivitas({super.key, required this.sizeControl});
  final SizeController sizeControl;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityController>(builder: (ctrl) {
      return Container(
        margin: EdgeInsets.symmetric(
            vertical: sizeControl.getHeightFromPrecentage(5),
            horizontal: sizeControl.getWidthFromPrecentage(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CalendarWidget(controller: controller, sizeControl: sizeControl),
            Container(
              width: sizeControl.getWidthFromPrecentage(25),
              padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: sizeControl.getWidthFromPrecentage(2)),
              height: 700,
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
              child: controller.isExists.value
                  ? Center(
                      child: Text('Anda sudah upload logbook hari ini'),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Tambah Aktivitas',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey.shade600),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: sizeControl.getWidthFromPrecentage(
                                  sizeControl.isLargeScreen.value ? 12 : 55),
                              child: Text(
                                'Apakah ada keterlibatan dengan karyawan ?',
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            SizedBox(
                              width: sizeControl.getWidthFromPrecentage(
                                  sizeControl.isLargeScreen.value ? 5 : 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Checkbox(
                                      value: controller.isWithEmployee.value,
                                      onChanged:
                                          controller.isWithEmployeeChanged),
                                  Text('Ya')
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: sizeControl.getWidthFromPrecentage(
                                  sizeControl.isLargeScreen.value ? 12 : 55),
                              child: Text(
                                'Apakah ada keterlibatan dengan tim ?',
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            SizedBox(
                              width: sizeControl.getWidthFromPrecentage(
                                  sizeControl.isLargeScreen.value ? 5 : 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Checkbox(
                                      value: controller.isWithTeam.value,
                                      onChanged: controller.isWithTeamChanged),
                                  Text('Ya')
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: sizeControl.getWidthFromPrecentage(20),
                          height: 60,
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            onChanged: controller.detailsOnChanged,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: const Text('Detail Kegiatan'),
                              // labelStyle: TextStyle(color: Colors.blue),
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
                        // Text('Masalah : '),
                        Container(
                            width: sizeControl.getWidthFromPrecentage(
                                sizeControl.isLargeScreen.value ? 20 : 85),
                            padding: const EdgeInsets.all(4.0),
                            height: 100,
                            // decoration: BoxDecoration(
                            // border: Border.all(color: Colors.blueGrey),
                            // borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              onChanged: controller.problemOnChanged,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2555)
                              ],
                              style: TextStyle(fontSize: 14),
                              maxLines: 10,
                              decoration: InputDecoration(
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
                                hintMaxLines: 10,
                                label: const Text('Masalah'),
                                hintStyle: TextStyle(fontSize: 14),
                                hintText: 'Tuliskan sebuah masalah disini ..  ',
                                border: InputBorder.none,
                              ),
                            )),

                        Container(
                            width: sizeControl.getWidthFromPrecentage(
                                sizeControl.isLargeScreen.value ? 20 : 85),
                            padding: const EdgeInsets.all(4.0),
                            height: 100,
                            // decoration: BoxDecoration(
                            // border: Border.all(color: Colors.blueGrey),
                            // borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              onChanged: controller.solutionOnChanged,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2555)
                              ],
                              style: TextStyle(fontSize: 14),
                              maxLines: 10,
                              decoration: InputDecoration(
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
                                hintMaxLines: 10,
                                label: const Text('Solusi'),
                                hintStyle: TextStyle(fontSize: 14),
                                hintText:
                                    'Tuliskan Solusi untuk masalahmu disini ..  ',
                                border: InputBorder.none,
                              ),
                            )),

                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          width: sizeControl.getWidthFromPrecentage(
                              sizeControl.isLargeScreen.value ? 20 : 85),
                          padding: const EdgeInsets.all(4.0),
                          height: 100,
                          // decoration: BoxDecoration(
                          // border: Border.all(color: Colors.blueGrey),
                          // borderRadius: BorderRadius.circular(15)),
                          child: DashedRect(
                              color: Colors.blueGrey.shade600,
                              strokeWidth: 2.0,
                              gap: 3.0,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10,
                                    top: 24,
                                    bottom: 24,
                                    right:
                                        sizeControl.getWidthFromPrecentage(10)),
                                child: MaterialButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  onPressed: () async {
                                    FilePickerResult? result = await FilePicker
                                        .platform
                                        .pickFiles(type: FileType.image);
                                    if (result != null) {
                                      if (kIsWeb) {
                                        Uint8List bytes =
                                            result.files.single.bytes!;
                                        controller.imageFileOnChanged(bytes);
                                      }
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.blue,
                                  child: Text(
                                    controller.imageFile != null
                                        ? 'File terpasang'
                                        : 'Pilih File',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        ),

                        Container(
                          width: sizeControl.getWidthFromPrecentage(14),
                          height: 35,
                          margin: EdgeInsets.symmetric(
                              horizontal: sizeControl.getWidthFromPrecentage(5),
                              vertical: 14),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            onPressed: controller.save,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.teal,
                            child: controller.onAsync.value
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Simpan',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        )
                      ],
                    ),
            )
          ],
        ),
      );
    });
  }
}

class CalendarWidget extends StatelessWidget {
  CalendarWidget(
      {Key? key, required this.controller, required this.sizeControl})
      : super(key: key);

  final ActivityController controller;
  final SizeController sizeControl;

  @override
  Widget build(BuildContext context) {
    final List<String> month = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return CalendarControllerProvider(
        controller: controller.eventController.value,
        child: SizedBox(
          width: sizeControl.getWidthFromPrecentage(40),
          height: sizeControl.getHeightFromPrecentage(90),
          child: MonthView(
            key: controller.monthViewKey.value,
            weekDayBuilder: controller.onMonthSelection.value
                ? (day) {
                    return Container();
                  }
                : null,
            cellBuilder: controller.onMonthSelection.value
                ? (date, event, isToday, isInMonth) {
                    return Container();
                  }
                : null,
            headerBuilder: (time) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: sizeControl.getWidthFromPrecentage(40),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.amberAccent.shade400,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                -1, 1), // changes position of shadow
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (controller.onMonthSelection.value) {
                                controller.openCloseMonthSelector();
                              }
                              controller.monthViewKey.value.currentState!
                                  .previousPage();
                              // controller.update();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            )),
                        GestureDetector(
                          onTap: () {
                            controller.openCloseMonthSelector();
                          },
                          child: Text(
                            DateFormat('MMMM - yyyy').format(time),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (controller.onMonthSelection.value) {
                                controller.openCloseMonthSelector();
                              }
                              controller.monthViewKey.value.currentState!
                                  .nextPage();
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  controller.onMonthSelection.value
                      ? Container(
                          height: 200,
                          margin: const EdgeInsets.only(top: 20, bottom: 15),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  sizeControl.getWidthFromPrecentage(2)),
                          child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                              crossAxisCount: 6,
                              children: List.generate(
                                  month.length,
                                  (index) => MaterialButton(
                                        onPressed: () {
                                          controller
                                              .monthViewKey.value.currentState!
                                              .animateToPage(index);
                                          controller.openCloseMonthSelector();
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        color: Colors.amber.shade400,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        child: Text(
                                          month[index],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )).toList()),
                        )
                      : Container()
                ],
              );
            },
            cellAspectRatio: 1,
            minMonth: DateTime(DateTime.now().year),
            initialMonth: DateTime(DateTime.now().year),
          ),
        ));
  }
}
