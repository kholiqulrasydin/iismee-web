import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/views/admin_layout/components/dropdown_menu.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';

import '../controllers/magang_participant_controller.dart';

class MagangParticipantView extends GetView<MagangParticipantController> {
  MagangParticipantView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return MainAdminLayout(
      // appBarTitle: 'IISMEE Presensi',
      appBarAction: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.print_rounded,
              color: Colors.blueGrey,
              size: 20,
            ))
        // SvgPicture.asset(
        //   'assets/icons/menu_notification.svg',
        //   color: Colors.blueGrey,
        //   height: 20,
        // )
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
            height: !sizeControl.isLargeScreen.value ? 150 : 50,
            child: !sizeControl.isLargeScreen.value
                ? Container(
                    margin: EdgeInsets.only(
                        left: sizeControl.getWidthFromPrecentage(5),
                        right: sizeControl.getWidthFromPrecentage(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Partisipan Magang',
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
                                'Masih Magang',
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
                      SizedBox(width: sizeControl.getWidthFromPrecentage(5)),
                      Text(
                        'Partisipan Magang',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey.shade700),
                      ),
                      SizedBox(
                        width: sizeControl.getWidthFromPrecentage(5),
                      ),
                      Container(
                        width: sizeControl.getWidthFromPrecentage(24),
                        margin: EdgeInsets.symmetric(
                            horizontal: sizeControl.getWidthFromPrecentage(1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          // controller.getMenuPage(sizeControl: sizeControl),
          const SizedBox(
            height: 20,
          ),

          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: sizeControl.getWidthFromPrecentage(8)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Participant(sizeControl: sizeControl),
                      Participant(sizeControl: sizeControl),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Participant(sizeControl: sizeControl),
                      Participant(sizeControl: sizeControl),
                    ],
                  ),
                ],
              ))
        ],
      ),
      sizeControl: sizeControl,
    );
  }
}

class Participant extends StatelessWidget {
  const Participant({
    Key? key,
    required this.sizeControl,
  }) : super(key: key);

  final SizeController sizeControl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeControl.getWidthFromPrecentage(32),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      //   decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(15),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.5),
      //       spreadRadius: 1,
      //       blurRadius: 3,
      //       offset: const Offset(-1, 1), // changes position of shadow
      //     ),
      //   ],
      // ),l;
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sizeControl.getWidthFromPrecentage(1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '19051397060',
                      style:
                          TextStyle(color: Colors.blue.shade900, fontSize: 18),
                    ),
                    Row(
                      children: [
                        Text(
                          'Status : ',
                          style: TextStyle(color: Colors.blueGrey.shade700),
                        ),
                        Text(
                          'Masih Magang',
                          style: TextStyle(color: Colors.teal.shade700),
                        )
                      ],
                    )
                  ],
                ),
                GesturedDropDown(
                  values: [
                    ItemMenu(title: 'Log Book & Presensi', onTap: () {print('Go to Logbook');}),
                    ItemMenu(title: 'Lihat Laporan', onTap: () {print('Go to Laporan');}),
                    ItemMenu(title: 'Lihat Nilai Akhir', onTap: () {print('Go to Nilai Akhir');})
                  ],
                  isHasValue: false,
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: Colors.blueGrey.shade700,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                  child: Divider(
                color: Colors.blueGrey.shade400,
                thickness: 0.5,
              ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sizeControl.getWidthFromPrecentage(1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/profile.png',
                    height: sizeControl.getWidthFromPrecentage(7.5),
                    width: sizeControl.getWidthFromPrecentage(5),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: sizeControl.getWidthFromPrecentage(20),
                  child: Column(
                    children: [
                      Text(
                        'nandya aura febyanissa yudiasmara'.capitalize!,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: Colors.blueGrey.shade700, fontSize: 20),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Icon(Icons.view_quilt_rounded),
                          Text('D4 Manajemen Informatika')
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: Colors.blueGrey.shade400,
                            thickness: 0.2,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
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
                                          text: 'Nama Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'PT. Pelayaran Nasional Indonesia'),
                                    ],
                                  )))
                        ],
                      ),
                      Row(
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
                                          text: 'Nama Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'PT. Pelayaran Nasional Indonesia'),
                                    ],
                                  )))
                        ],
                      ),
                      Row(
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
                                          text: 'Nama Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'PT. Pelayaran Nasional Indonesia'),
                                    ],
                                  )))
                        ],
                      ),
                      Row(
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
                                          text: 'Nama Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'PT. Pelayaran Nasional Indonesia'),
                                    ],
                                  )))
                        ],
                      ),
                      Row(
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
                                          text: 'Nama Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'PT. Pelayaran Nasional Indonesia'),
                                    ],
                                  )))
                        ],
                      ),
                      Row(
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
                                          text: 'Nama Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'PT. Pelayaran Nasional Indonesia'),
                                    ],
                                  )))
                        ],
                      ),
                      Row(
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
                                          text: 'Nama Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'PT. Pelayaran Nasional Indonesia'),
                                    ],
                                  )))
                        ],
                      ),
                      Row(
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
                                          text: 'Nama Instansi : ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'PT. Pelayaran Nasional Indonesia'),
                                    ],
                                  )))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
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
