import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:ionicons/ionicons.dart';

class MahasiswaPieChart extends StatefulWidget {
  const MahasiswaPieChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MahasiswaPieChartState();
}

class MahasiswaPieChartState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          touchedIndex = -1;
        });
      },
      hoverColor: Colors.white,
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: PieChart(
                PieChartData(
                  // pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  //   // setState(() {
                  //   //   // final desiredTouch =
                  //   //   //     touchEvent is! PointerExitEvent &&
                  //   //   //         touchEvent is! PointerUpEvent;
                  //   //   // if (desiredTouch &&
                  //   //   //     pieTouchResponse!.touchedSection != null) {
                  //   //   //   touchedIndex = pieTouchResponse
                  //   //   //       .touchedSection!.touchedSectionIndex;
                  //   //   // } else {
                  //   //   //   touchedIndex = -1;
                  //   //   // }
                  //   // });
                  // }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 01,
                  centerSpaceRadius: 20,
                  sections: showingSections(i: 1),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        touchedIndex = 0;
                      });
                    },
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(04.0),
                          child: const Icon(
                            Ionicons.square,
                            color: Colors.blue,
                          ),
                        ),
                        const Text('Sudah Upload Laporan'),
                      ],
                    ),
                  ),

                  InkWell(
                    onHover: (value) {
                      setState(() {
                        touchedIndex = 0;
                      });
                    },
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(04.0),
                          child: const Icon(
                            Ionicons.square,
                            color: Colors.amber,
                          ),
                        ),
                        const Text('Belum Upload Laporan'),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections({required int i}) {
    var currentWidth = MediaQuery.of(context).size.width;
    var extraScreenGrid = currentWidth > 1536;
    var largeScreenGrid = currentWidth > 1366;
    var smallScreenGrid = currentWidth > 1201;
    var extraSmallScreenGrid = currentWidth > 1025;
    var tabScreenGrid = currentWidth > 769;
    var mobileScreenGrid = currentWidth > 481;

    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = 85.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 70,
            title: '70%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.amber,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }
}
