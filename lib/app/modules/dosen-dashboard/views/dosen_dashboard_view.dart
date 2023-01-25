import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/dosen-dashboard/views/chart.dart';
import 'package:iismee/app/modules/presensi/views/presensi_view.dart';
import 'package:iismee/app/views/admin_layout/components/decorated_status_box.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';

import '../controllers/dosen_dashboard_controller.dart';

class DosenDashboardView extends GetView<DosenDashboardController> {
  DosenDashboardView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    sizeControl.createSize(context);
    return MainAdminLayout(
      sizeControl: sizeControl,
      body: Column(
        children: [
          Container(
            height: sizeControl.isLargeScreen.value ? 120 : 360,
            width: sizeControl.getWidthFromPrecentage(sizeControl.isLargeScreen.value ? 80 : 90),
            margin: sizeControl.isLargeScreen.value ? EdgeInsets.only(top: 10, bottom : 10, left: sizeControl.getWidthFromPrecentage(2)) : EdgeInsets.symmetric(vertical: 10, horizontal: sizeControl.getWidthFromPrecentage(2)),
            child: SingleChildScrollView(
              scrollDirection: sizeControl.isLargeScreen.value ? Axis.horizontal : Axis.vertical,
              child: ResponsiveRowToColumn(
                condition: sizeControl.isLargeScreen.value, 
                children: [
                  DecoratedStatusBox(width: sizeControl.isLargeScreen.value ? 282 : sizeControl.getWidthFromPrecentage(80), sizeControl: sizeControl, title: 'Mahasiswa Riset', latestUpdated: 'Sekarang', status: '0', statusColor: Colors.amber.shade800,),
                  DecoratedStatusBox(width: sizeControl.isLargeScreen.value ? 282 : sizeControl.getWidthFromPrecentage(80), sizeControl: sizeControl, title: 'Mahasiswa Praktik Industri', latestUpdated: 'Sekarang', status: '25', statusColor: Colors.blue.shade800,),
                  DecoratedStatusBox(width: sizeControl.isLargeScreen.value ? 282 : sizeControl.getWidthFromPrecentage(80), sizeControl: sizeControl, title: 'Penilaian Mahasiswa', latestUpdated: 'Sekarang', status: '75% dinilai', statusColor: Colors.purple.shade800,),
                  DecoratedStatusBox(width: sizeControl.isLargeScreen.value ? 282 : sizeControl.getWidthFromPrecentage(80), sizeControl: sizeControl, title: 'Percakapan Aktif', latestUpdated: 'Sekarang', status: '2', statusColor: Colors.blue.shade800,)
                  ]
                ),
            ),
          ),
          Container(
            height: sizeControl.isLargeScreen.value ? 320 : 650,
            width: sizeControl.getWidthFromPrecentage(sizeControl.isLargeScreen.value ? 80 : 90),
            margin: EdgeInsets.only(bottom: 10, left: sizeControl.getWidthFromPrecentage(3), right: sizeControl.getWidthFromPrecentage(3)),
            child: ResponsiveRowToColumn(
              rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
              columnMainAxisAlignment: MainAxisAlignment.spaceBetween,
              condition: sizeControl.isLargeScreen.value,
              children: [
                Container(
                  height: 320,
                  width: sizeControl.getWidthFromPrecentage(sizeControl.isLargeScreen.value ? 33.5 : 80),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                Icon(Icons.note_alt_sharp,),
                                Text('Persyaratan pendaftaran Magang')
                              ],
                            )
                        ]),
                      ),
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.last_page_outlined),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('IPK Mahasiswa', style: TextStyle(fontWeight: FontWeight.w600),),
                                Text('IPK mahasiswa pada semester aktif minimal 2.75')
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.add_chart_sharp),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Perolehan SKS yang telah ditempuh', style: TextStyle(fontWeight: FontWeight.w600),),
                                Text('Minimal menempuh 80 SKS', overflow: TextOverflow.clip,)
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person_outline),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mahasiswa Aktif', style: TextStyle(fontWeight: FontWeight.w600),),
                                Text('Mahasiswa harus berstatus aktif', overflow: TextOverflow.clip,)
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.note),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Unggah Surat pengantar magang', style: TextStyle(fontWeight: FontWeight.w600),),
                                Text('Peserta Magang diwajibkan untuk unggah surat pengantar', overflow: TextOverflow.clip,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 320,
                  width: sizeControl.getWidthFromPrecentage(sizeControl.isLargeScreen.value ? 40 : 80),
                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
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
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      MahasiswaPieChart(),
                      Positioned(
                        top: 5,
                        left: 15,
                        child: Text('Presentase Mahasiswa Upload Laporan : ', style: TextStyle(fontWeight: FontWeight.w600),),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: sizeControl.isLargeScreen.value ? 300 : 920,
            width: sizeControl.getWidthFromPrecentage(sizeControl.isLargeScreen.value ? 80 : 90),
            margin: EdgeInsets.only(bottom: 10, top: 10, left: sizeControl.getWidthFromPrecentage(3), right: sizeControl.getWidthFromPrecentage(3)),
            child: ResponsiveRowToColumn(
              condition: sizeControl.isLargeScreen.value,
              rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
              columnMainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 300,
                  width: sizeControl.getWidthFromPrecentage(sizeControl.isLargeScreen.value ? 24 : 80),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  alignment: Alignment.center,
                  child: const Text('Shortcut magang participant, filtered by tempat magang', overflow: TextOverflow.clip,),
                ),
                Container(
                  height: 300,
                  width: sizeControl.getWidthFromPrecentage(sizeControl.isLargeScreen.value ? 24 : 80),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                ),
                Container(
                  height: 300,
                  width: sizeControl.getWidthFromPrecentage(sizeControl.isLargeScreen.value ? 24 : 80),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  alignment: Alignment.center,
                  child: const Text('Recently Mahasiswa sunting / upload laporan', overflow: TextOverflow.clip,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
