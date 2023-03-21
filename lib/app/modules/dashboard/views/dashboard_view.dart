import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/magang-participant/views/magang_participant_view.dart';
import 'package:iismee/app/views/admin_layout/components/decorated_status_box.dart';
import 'package:iismee/app/views/admin_layout/components/responsive_layout.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();
  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return MainAdminLayout(
      sizeControl: sizeControl,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Dashboard',
                        style: TextStyle(
                            color: Colors.blueGrey.shade600, fontSize: 36),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'IISMEE / Dashboard',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                      )
                    ],
                  ),
                ],
              )),
          Container(
            height: sizeControl.isLargeScreen.value ? 500 : 650,
            width: sizeControl.getWidthFromPrecentage(
                sizeControl.isLargeScreen.value ? 80 : 90),
            margin: EdgeInsets.only(
                bottom: 10,
                left: sizeControl.getWidthFromPrecentage(3),
                right: sizeControl.getWidthFromPrecentage(3)),
            child: ResponsiveRowToColumn(
              rowMainAxisAlignment: MainAxisAlignment.start,
              columnMainAxisAlignment: MainAxisAlignment.spaceBetween,
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              condition: sizeControl.isLargeScreen.value,
              children: [
                Container(
                  height: 500,
                  width: sizeControl.getWidthFromPrecentage(
                      sizeControl.isLargeScreen.value ? 33.5 : 80),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(-1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.note_alt_sharp,
                                  ),
                                  Text('Data diri')
                                ],
                              )
                            ]),
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/profile.png',
                                    height: 75,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: sizeControl.getWidthFromPrecentage(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'andini nur aini'.capitalize!,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade700,
                                            fontSize: 20),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            MagangParticipantProfileItem(
                              sizeControl: sizeControl,
                              label: 'Nama Instansi',
                              detail: 'PT. Pelayaran Nasional Indonesia',
                            ),
                            MagangParticipantProfileItem(
                              sizeControl: sizeControl,
                              label: 'Bidang Instansi',
                              detail: 'Teknologi',
                            ),
                            MagangParticipantProfileItem(
                              sizeControl: sizeControl,
                              label: 'Periode Magang',
                              detail: 'Semester 2021 / 2022',
                            ),
                            MagangParticipantProfileItem(
                              sizeControl: sizeControl,
                              label: 'Program',
                              detail: 'Mandiri Program Studi (20 SKS)',
                            ),
                            MagangParticipantProfileItem(
                              sizeControl: sizeControl,
                              label: 'Jenis Magang',
                              detail: 'Praktik Industri',
                            ),
                            MagangParticipantProfileItem(
                              sizeControl: sizeControl,
                              label: 'Jenis Konversi',
                              detail: 'Konversi Matakuliah',
                            ),
                            MagangParticipantProfileItem(
                              sizeControl: sizeControl,
                              label: 'Posisi Magang',
                              detail: 'Layanan Aplikasi',
                            ),
                            MagangParticipantProfileItem(
                              sizeControl: sizeControl,
                              label: 'Tanggal Pelaksanaan',
                              detail: '19-05-2022 Sampai 24-07-2022',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: sizeControl.isLargeScreen.value ? 500 : 360,
                  width: sizeControl.getWidthFromPrecentage(
                      sizeControl.isLargeScreen.value ? 22 : 80),
                  margin: sizeControl.isLargeScreen.value
                      ? EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: sizeControl.getWidthFromPrecentage(2))
                      : EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: sizeControl.getWidthFromPrecentage(2)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      DecoratedStatusBox(
                        width: sizeControl.isLargeScreen.value
                            ? 400
                            : sizeControl.getWidthFromPrecentage(80),
                        sizeControl: sizeControl,
                        title: 'Status Presensi',
                        latestUpdated: 'Sekarang',
                        status: 'Belum presensi',
                        statusColor: Colors.red.shade800,
                      ),
                      DecoratedStatusBox(
                        width: sizeControl.isLargeScreen.value
                            ? 400
                            : sizeControl.getWidthFromPrecentage(80),
                        sizeControl: sizeControl,
                        title: 'Status logbook',
                        latestUpdated: 'Hari ini',
                        status: 'Belum diisi',
                        statusColor: Colors.purple.shade800,
                      ),
                      DecoratedStatusBox(
                        width: sizeControl.isLargeScreen.value
                            ? 400
                            : sizeControl.getWidthFromPrecentage(80),
                        sizeControl: sizeControl,
                        title: 'Status Laporan',
                        latestUpdated: 'Sekarang',
                        status: 'Sudah diupload',
                        statusColor: Colors.blue.shade800,
                      ),
                      DecoratedStatusBox(
                        width: sizeControl.isLargeScreen.value
                            ? 400
                            : sizeControl.getWidthFromPrecentage(80),
                        sizeControl: sizeControl,
                        title: 'Status Penilaian',
                        latestUpdated: 'Sekarang',
                        status: 'Belum dinilai',
                        statusColor: Colors.red.shade800,
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
