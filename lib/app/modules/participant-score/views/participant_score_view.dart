import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';

import '../controllers/participant_score_controller.dart';

class ParticipantScoreView extends GetView<ParticipantScoreController> {
  ParticipantScoreView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    controller.createSize(context);
    sizeControl.createSize(context);
    return GetBuilder<ParticipantScoreController>(
      builder: ((controller) {
        return MainAdminLayout(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeControl.getWidthFromPrecentage(5)),
            child: Column(
              children: [
                if(sizeControl.isLargeScreen.value)
                  Container(
                      margin: EdgeInsets.symmetric(vertical: sizeControl.getHeightFromPrecentage(2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SearchWidget(sizeControl: sizeControl),
                          SizedBox(
                            width: 250,
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: controller.menuPages.isEmpty ? [Container()] : controller.menuPages,
                            ),
                          )
                        ],
                      ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.participantsList.isEmpty ? [Container()] : controller.participantsList,
                    ),
                    Container(
                      width: sizeControl.getWidthFromPrecentage(30),
                      height: 600,
                      alignment: Alignment.center,
                      child: controller.table.value,
                    )
                  ],
                ),
              ],
            ),
          ), sizeControl: sizeControl,
        );
      }
    ));
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
                  color: isSelected ? Colors.blueAccent.shade100 : Color.fromARGB(252, 242, 242, 255),
                  borderRadius: BorderRadius.circular(15)),
            )
          ],
        ),
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

class Participant extends StatelessWidget {
  const Participant({
    Key? key,
    required this.name, required this.sizeControl, required this.details, this.onTap, required this.isSelected
  }) : super(key: key);

  final bool isSelected;
  final Function()? onTap;
  final String name;
  final SizeController sizeControl;
  final List<ParticipantDetail> details;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: sizeControl.getWidthFromPrecentage(isSelected ? 33 : 32),
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.blue : Colors.transparent),
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
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: sizeControl.getWidthFromPrecentage(1)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Text(
            //             '19051397060',
            //             style: TextStyle(
            //                 color: Colors.blue.shade900, fontSize: 18),
            //           ),
            //           Row(
            //             children: [
            //               Text(
            //                 'Status : ',
            //                 style:
            //                     TextStyle(color: Colors.blueGrey.shade700),
            //               ),
            //               Text(
            //                 'Masih Magang',
            //                 style: TextStyle(color: Colors.teal.shade700),
            //               )
            //             ],
            //           )
            //         ],
            //       ),
            //       IconButton(
            //           onPressed: () {
            //             // Log book & presensi 
            //             // lihat Laporan
            //             // lihat nilai akhir
            //           },
            //           icon: Icon(
            //             Icons.more_vert_rounded,
            //             color: Colors.blueGrey.shade700,
            //           ))
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //         child: Divider(
            //       color: Colors.blueGrey.shade400,
            //       thickness: 0.5,
            //     ))
            //   ],
            // ),
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
                      Row(
                        children: [
                          Icon(Icons.view_quilt_rounded),
                          Text('D4 Manajemen Informatika')
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      ...details
                      
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
    required this.sizeControl, required this.title, required this.detail,
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
            width:
                sizeControl.getWidthFromPrecentage(18),
            child: RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: title,
                        style: const TextStyle(
                            fontWeight:
                                FontWeight.bold)),
                    TextSpan(
                        text:
                            detail
                            ),
                  ],
                )))
      ],
    );
  }
}