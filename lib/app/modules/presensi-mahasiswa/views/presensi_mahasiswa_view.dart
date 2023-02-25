import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/views/admin_layout/components/responsive_layout.dart';
import 'package:iismee/app/views/admin_layout/components/search_widget.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';
import 'package:intl/intl.dart';

import '../controllers/presensi_mahasiswa_controller.dart';

class PresensiMahasiswaView extends GetView<PresensiMahasiswaController> {
  PresensiMahasiswaView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return GetBuilder<PresensiMahasiswaController>(builder: (context) {
      return MainAdminLayout(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: sizeControl.getWidthFromPrecentage(5),
                    vertical: 20),
                child: ResponsiveRowToColumn(
                    condition: sizeControl.isLargeScreen.value,
                    rowCrossAxisAlignment: CrossAxisAlignment.center,
                    rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Presensi',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey.shade700),
                      ),
                      if (controller.selectedParticipant != null)
                        ResponsiveRowToColumn(
                            condition: sizeControl.isLargeScreen.value,
                            rowMainAxisAlignment: MainAxisAlignment.end,
                            rowCrossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Text('Status  '),
                                    PeriodeDropDown(
                                      values: [
                                        'Sudah Presensi',
                                        'Belum Presensi'
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Text('Status  '),
                                    PeriodeDropDown(
                                      values: [
                                        'Aktif Magang',
                                        'Sudah Berakhir',
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SearchWidget(
                                sizeControl: sizeControl,
                              )
                            ])
                    ]),
              ),
              if (controller.selectedParticipant == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 50),
                      alignment: Alignment.center,
                      child: ResponsiveRowToColumn(
                          condition: sizeControl.isLargeScreen.value,
                          rowMainAxisAlignment: MainAxisAlignment.center,
                          rowCrossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Text('Status  '),
                                  PeriodeDropDown(
                                    values: [
                                      'Sudah Presensi',
                                      'Belum Presensi'
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SearchWidget(
                              sizeControl: sizeControl,
                            )
                          ]),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: sizeControl.getWidthFromPrecentage(70),
                        height: sizeControl.getHeightFromPrecentage(80),
                        child: Participants(
                          sizeControl: sizeControl,
                          participants: controller.participantList,
                        ),
                      ),
                    )
                  ],
                ),
              if (controller.selectedParticipant != null)
                Container(
                  margin: EdgeInsets.only(
                      left: sizeControl.getWidthFromPrecentage(2)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Lainnya : ',
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade600),
                                )),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    controller.participantList.map((element) {
                                  return ParticipantsItem(
                                    isSelected: controller.participantList
                                            .indexOf(element) ==
                                        controller.selectedParticipant!.value,
                                    index: controller.participantList
                                        .indexOf(element),
                                    controller: controller,
                                    participantElement: element,
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ResponsiveRowToColumn(
                          rowMainAxisAlignment: MainAxisAlignment.spaceAround,
                          rowCrossAxisAlignment: CrossAxisAlignment.start,
                          condition: sizeControl.isLargeScreen.value,
                          children: [
                            SizedBox(
                              width: sizeControl.getWidthFromPrecentage(40),
                              child: CalendarWidget(
                                controller: controller,
                                sizeControl: sizeControl,
                              ),
                            ),
                            SizedBox(
                              width: sizeControl.getWidthFromPrecentage(30),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.asset(
                                            'assets/profile.png',
                                            height: 70,
                                            width: 50,
                                            fit: BoxFit.fill,
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    overflow: TextOverflow.clip,
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blueGrey.shade700,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: 'Nama : ',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                            text: controller
                                                                    .participantList[
                                                                controller
                                                                    .selectedParticipant!
                                                                    .value]['nama']),
                                                      ],
                                                    )),
                                                RichText(
                                                    overflow: TextOverflow.clip,
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blueGrey.shade700,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: 'NIM : ',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                            text: controller
                                                                    .participantList[
                                                                controller
                                                                    .selectedParticipant!
                                                                    .value]['nim']),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    overflow: TextOverflow.clip,
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blueGrey.shade700,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                'Total Presensi : ',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                            text:
                                                                '5 dari 280 hari'),
                                                      ],
                                                    )),
                                                RichText(
                                                    overflow: TextOverflow.clip,
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blueGrey.shade700,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                'Total Izin : ',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                            text:
                                                                '1 dari 5 presensi'),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ])
                    ],
                  ),
                )
            ],
          ),
          sizeControl: sizeControl);
    });
  }
}

class ParticipantsItem extends StatelessWidget {
  const ParticipantsItem({
    super.key,
    required this.isSelected,
    required this.participantElement,
    this.onTap,
    required this.index,
    required this.controller,
  });

  final bool isSelected;
  final Map<String, dynamic> participantElement;
  final Function()? onTap;
  final int index;
  final PresensiMahasiswaController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectParticipant(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: EdgeInsets.only(right: 15, bottom: 10, top: 10, left: 10),
        width: isSelected ? 270 : 250,
        height: isSelected ? 90 : 80,
        decoration: BoxDecoration(
          border:
              Border.all(color: isSelected ? Colors.blue : Colors.transparent),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/profile.png',
                height: 70,
                width: 50,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.blueGrey.shade700,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Nama : ',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: participantElement['nama']),
                      ],
                    )),
                RichText(
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.blueGrey.shade700,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'NIM : ',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: participantElement['nim']),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  CalendarWidget(
      {Key? key, required this.controller, required this.sizeControl})
      : super(key: key);

  final PresensiMahasiswaController controller;
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

class Participants extends StatelessWidget {
  Participants(
      {super.key,
      required this.participants,
      required this.sizeControl,
      this.onSelected});
  final List<Map<String, dynamic>> participants;
  final SizeController sizeControl;
  final Function()? onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(participants.length, (index) {
        return GestureDetector(
          onTap: onSelected,
          child: Container(
            width: 200,
            height: 270,
            margin: const EdgeInsets.all(10),
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/profile.png',
                        height: 100,
                        width: 70,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      participants[index]['nama'],
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.blueGrey.shade700, fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                              // margin: EdgeInsets.only(left: sizeControl.getWidthFromPrecentage(1)),
                              width: sizeControl.getWidthFromPrecentage(12),
                              child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade700,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'NIM : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: participants[index]['nim']),
                                    ],
                                  ))),
                          Container(
                              // margin: EdgeInsets.only(left: sizeControl.getWidthFromPrecentage(1)),
                              width: sizeControl.getWidthFromPrecentage(12),
                              child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade700,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: participants[index]
                                              ['instansi']),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    width: 150,
                    height: 20,
                    decoration: BoxDecoration(
                        color: participants[index]['statusPresensiHariIni']
                            ? Colors.teal
                            : Colors.red.shade700,
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: Text(
                      participants[index]['statusPresensiHariIni']
                          ? 'Hari ini sudah presensi'
                          : 'Hari ini belum presensi',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PeriodeDropDown extends StatefulWidget {
  PeriodeDropDown({super.key, required this.values});

  final List<String> values;
  @override
  State<PeriodeDropDown> createState() => _PeriodeDropDownState();
}

class _PeriodeDropDownState extends State<PeriodeDropDown> {
  List<String> list = [];
  String dropdownValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.values;
    dropdownValue = widget.values.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      elevation: 16,
      style: TextStyle(color: Colors.blueGrey.shade700),
      underline: Container(
        height: 2,
        color: Colors.blueAccent.shade700,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
