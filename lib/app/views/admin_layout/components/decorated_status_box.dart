import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iismee/app/controllers/size_controller.dart';

class DecoratedStatusBox extends StatelessWidget {
   const DecoratedStatusBox(
      {super.key,
      required this.sizeControl,
      required this.title,
      required this.latestUpdated,
      required this.status,
      this.statusColor = const Color.fromARGB(255, 198, 40, 40), 
      this.width = 300
      });
  final SizeController sizeControl;
  final String title;
  final String latestUpdated;
  final String status;
  final Color statusColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 80,
      margin: EdgeInsets.symmetric(
          horizontal: sizeControl.getWidthFromPrecentage(0.8), vertical: 5),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade800),
              ),
              Text(
                status,
                style: TextStyle(fontSize: 16, color: statusColor),
              ),
              Row(
                children: [
                  Text('terakhir diperbarui : ',
                      style: TextStyle(
                          fontSize: 12, color: Colors.blueGrey.shade800)),
                  Text(latestUpdated,
                      style:
                          TextStyle(fontSize: 12, color: Colors.teal.shade800)),
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
    );
  }
}
