import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';

import '../controllers/log_book_controller.dart';

class LogBookView extends GetView<LogBookController> {
  LogBookView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    controller.createSize(context);
    sizeControl.createSize(context);

    return GetBuilder<LogBookController>(builder: (context) {
      return MainAdminLayout(
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sizeControl.getWidthFromPrecentage(5),
                vertical: sizeControl.getHeightFromPrecentage(1)),
            child: Column(
              crossAxisAlignment: sizeControl.isLargeScreen.value
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                if (sizeControl.isLargeScreen.value)
                  SizedBox(height: sizeControl.getHeightFromPrecentage(2)),
                Container(
                  margin: EdgeInsets.only(
                      top: sizeControl.getHeightFromPrecentage(1)),
                  height: !sizeControl.isLargeScreen.value ? 150 : 50,
                  child: !sizeControl.isLargeScreen.value
                      ? Container(
                          margin: EdgeInsets.only(
                              left: sizeControl.getWidthFromPrecentage(5),
                              right: sizeControl.getWidthFromPrecentage(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Log Book',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade700),
                              ),
                              Row(
                                children: [
                                  Text('Periode  '),
                                  PeriodeDropDown(
                                    values: [
                                      '2019 / 2020',
                                      '2020 / 2021',
                                      '2021 / 2022',
                                      '2022 / 2023'
                                    ],
                                  ),
                                ],
                              ),
                              Row(
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
                            ],
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Log Book',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey.shade700),
                            ),
                            SizedBox(
                              width: sizeControl.getWidthFromPrecentage(
                                  controller.selectedParticipant == null
                                      ? 25
                                      : 8),
                            ),

                            Container(
                              width: sizeControl.getWidthFromPrecentage(24),
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      sizeControl.getWidthFromPrecentage(1)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text('Periode  '),
                                      PeriodeDropDown(
                                        values: [
                                          '2019 / 2020',
                                          '2020 / 2021',
                                          '2021 / 2022',
                                          '2022 / 2023'
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Status  '),
                                      PeriodeDropDown(
                                        values: [
                                          'Semua',
                                          'Masih Magang',
                                          'Sudah Berakhir',
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(width: sizeControl.getWidthFromPrecentage(18)),
                            // Container(
                            //     margin: const EdgeInsets.only(top: 25),
                            //     width: sizeControl.getWidthFromPrecentage(20),
                            //     child: SingleChildScrollView(
                            //       scrollDirection: Axis.horizontal,
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: controller.pageMenus,
                            //       ),
                            //     )),
                            if (controller.selectedParticipant != null)
                              SearchWidget(sizeControl: sizeControl),
                            Container(
                              margin: EdgeInsets.only(
                                  left: sizeControl.getWidthFromPrecentage(1)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.print_rounded,
                                    color: Colors.blueGrey,
                                    size: 20,
                                  )),
                              // child: GestureDetector(
                              //   onTap: () {},
                              //   child: SvgPicture.asset(
                              //     'assets/icons/menu_notification.svg',
                              //     color: Colors.blueGrey,
                              //     height: 20,
                              //   ),
                              // ),
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
                const SizedBox(
                  height: 50,
                ),
                if (controller.selectedParticipant == null)
                  Center(
                      child: SearchWidget(
                          sizeControl: sizeControl,
                          width: sizeControl.getWidthFromPrecentage(25))),
                const SizedBox(
                  height: 30,
                ),
                if (controller.selectedParticipant != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 600,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: controller.participantsList.isEmpty
                                ? [Container()]
                                : controller.participantsList,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 600,
                          // alignment: Alignment.center,
                          child: controller.table!.value,
                        ),
                      )
                    ],
                  ),
                if (controller.selectedParticipant == null)
                  controller.table == null
                      ? Container()
                      : SizedBox(height: 800, child: controller.table!.value)
              ],
            ),
          ),
          sizeControl: sizeControl);
    });
  }
}

class Participants extends StatelessWidget {
  Participants({super.key, required this.participants});
  final List<Participant> participants;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(participants.length, (index) {
        return participants[index];
      }),
    );
  }
}

class LogBookTable extends StatefulWidget {
  const LogBookTable({super.key});

  @override
  State<LogBookTable> createState() => _LogBookTableState();
}

class _LogBookTableState extends State<LogBookTable> {
  final sizeControl = Get.find<SizeController>();
  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      dataRowHeight: 150,
      columns: [
        DataColumn2(label: Text('No'), fixedWidth: 50, size: ColumnSize.M),
        DataColumn2(
            label: Text('Nama Kegiatan'), fixedWidth: 150, size: ColumnSize.M),
        DataColumn2(
            label: Text('Deskripsi Kegiatan'),
            size: ColumnSize.L,
            fixedWidth: 150),
        DataColumn2(
            label: Text('Keterangan'), fixedWidth: 125, size: ColumnSize.L),
        DataColumn2(
            label: Text('Masukan Pembimbing'),
            fixedWidth: 200,
            size: ColumnSize.L),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('1')),
          DataCell(Text('Mengelola alat K3')),
          DataCell(Text(
              'Menyortir perlengkapan K3 dengan susunan yang lebih efektif')),
          DataCell(Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Bersama Karyawan : '),
                SizedBox(
                  height: 5,
                ),
                SvgPicture.asset(
                  'assets/icons/pdf_file.svg',
                  height: 25,
                ),
                Text(
                  'photo.jpg',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.blue),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Diunggah pada 24 Februari 2023')
              ],
            ),
          )),
          DataCell(
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (val) {},
              ),
            ),
          ),
        ]),
        DataRow(cells: [
          DataCell(Text('1')),
          DataCell(Text('Mengelola alat K3')),
          DataCell(Text(
              'Menyortir perlengkapan K3 dengan susunan yang lebih efektif')),
          DataCell(Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Bersama Karyawan : '),
                SizedBox(
                  height: 5,
                ),
                SvgPicture.asset(
                  'assets/icons/pdf_file.svg',
                  height: 25,
                ),
                Text(
                  'photo.jpg',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.blue),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Diunggah pada 24 Februari 2023')
              ],
            ),
          )),
          DataCell(
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (val) {},
              ),
            ),
          ),
        ]),
        DataRow(cells: [
          DataCell(Text('1')),
          DataCell(Text('Mengelola alat K3')),
          DataCell(Text(
              'Menyortir perlengkapan K3 dengan susunan yang lebih efektif')),
          DataCell(Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Bersama Karyawan : '),
                SizedBox(
                  height: 5,
                ),
                SvgPicture.asset(
                  'assets/icons/pdf_file.svg',
                  height: 25,
                ),
                Text(
                  'photo.jpg',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.blue),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Diunggah pada 24 Februari 2023')
              ],
            ),
          )),
          DataCell(
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (val) {},
              ),
            ),
          ),
        ]),
      ],
    );
  }
}

class Participant extends StatelessWidget {
  const Participant(
      {Key? key,
      required this.name,
      required this.sizeControl,
      required this.details,
      this.onTap,
      required this.isSelected,
      required this.isTableNull})
      : super(key: key);

  final bool isSelected;
  final Function()? onTap;
  final String name;
  final SizeController sizeControl;
  final List<ParticipantDetail> details;
  final bool isTableNull;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: sizeControl.getWidthFromPrecentage(isTableNull
            ? 32
            : isSelected
                ? 22
                : 20),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
        child: isTableNull
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/profile.png',
                      height: sizeControl.getWidthFromPrecentage(8),
                      width: sizeControl.getWidthFromPrecentage(7),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    name.capitalize!,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700, fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                            // margin: EdgeInsets.only(left: sizeControl.getWidthFromPrecentage(1)),
                            width: sizeControl.getWidthFromPrecentage(10),
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
                                    TextSpan(text: '190051397046'),
                                  ],
                                )))
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizeControl.getWidthFromPrecentage(1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: isTableNull
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/profile.png',
                            height: sizeControl.getWidthFromPrecentage(6),
                            width: sizeControl.getWidthFromPrecentage(5),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name.capitalize!,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Colors.blueGrey.shade700,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                      // margin: EdgeInsets.only(left: sizeControl.getWidthFromPrecentage(1)),
                                      width: sizeControl
                                          .getWidthFromPrecentage(10),
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
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(text: '190051397046'),
                                            ],
                                          )))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ParticipantDetail extends StatelessWidget {
  const ParticipantDetail({
    Key? key,
    required this.sizeControl,
    required this.title,
    required this.detail,
  }) : super(key: key);

  final SizeController sizeControl;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.arrow_right_rounded,
          color: Colors.blueGrey.shade900,
        ),
        SizedBox(
            width: sizeControl.getWidthFromPrecentage(18),
            child: RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: detail),
                  ],
                )))
      ],
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key, required this.sizeControl, this.width})
      : super(key: key);

  final SizeController sizeControl;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(
          horizontal: sizeControl.getWidthFromPrecentage(1), vertical: 10),
      width: width ?? sizeControl.getWidthFromPrecentage(18),
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
            width: width == null
                ? sizeControl.getWidthFromPrecentage(14)
                : width! - sizeControl.getWidthFromPrecentage(4),
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
