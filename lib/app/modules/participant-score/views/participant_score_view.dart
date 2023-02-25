import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/modules/participant-score/controllers/instrument.dart';
import 'package:iismee/app/views/admin_layout/screens/main/main_screen.dart';

import '../controllers/participant_score_controller.dart';

class ParticipantScoreView extends GetView<ParticipantScoreController> {
  ParticipantScoreView({Key? key}) : super(key: key);
  final sizeControl = Get.find<SizeController>();

  @override
  Widget build(BuildContext context) {
    controller.createSize(context);
    sizeControl.createSize(context);
    return GetBuilder<ParticipantScoreController>(builder: ((controller) {
      return MainAdminLayout(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: sizeControl.getWidthFromPrecentage(2)),
          child: Column(
            children: [
              if (sizeControl.isLargeScreen.value)
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: sizeControl.getHeightFromPrecentage(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SearchWidget(sizeControl: sizeControl),
                      SizedBox(
                        width: 600,
                        height: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: controller.menuPages.isEmpty
                              ? [Container()]
                              : controller.menuPages,
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
                    children: controller.participantsList.isEmpty
                        ? [Container()]
                        : controller.participantsList,
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      // width: sizeControl.getWidthFromPrecentage(controller.selectedParticipant != null ? 45 : 35),
                      height: sizeControl.getHeightFromPrecentage(80),
                      alignment: Alignment.center,
                      // child: controller.table.value,
                      child: controller.table.value,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        sizeControl: sizeControl,
      );
    }));
  }
}

class PelaporanProgram extends StatefulWidget {
  const PelaporanProgram({super.key});

  @override
  State<PelaporanProgram> createState() => _PelaporanProgramState();
}

class _PelaporanProgramState extends State<PelaporanProgram> {
  List<Instrument> pelaporanProgram = DummyInstrument.pelaporanProgramA;
  int scoreTotal = 0;
  giveScore(int index, int? value) {
    if (value == null) {
      print("Score is null");
      setState(() {
        pelaporanProgram[index].finalScore = null;
      });
    } else {
      setState(() {
        pelaporanProgram[index].finalScore = value;
      });
      getfinalScoreTotal();
    }
  }

  getfinalScoreTotal() {
    int total = 0;
    pelaporanProgram.forEach((element) {
      if (element.finalScore != null) {
        total += element.finalScore!;
      }
    });
    total = (total / 45 * 100).toInt();
    setState(() {
      scoreTotal = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.print_rounded,
                      color: Colors.blueGrey,
                    )),
                SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  minWidth: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  onPressed: () {},
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 800,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(15),
                //     topRight: Radius.circular(15)),
                border: Border(
                    bottom: BorderSide(color: Colors.blueGrey),
                    top: BorderSide(color: Colors.blueGrey))
                // borderRadius: BorderRadius.circular(15),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 3,
                //     offset: const Offset(
                //         -1, 1), // changes position of shadow
                //   ),
                // ],
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 20,
                  alignment: Alignment.centerLeft,
                  child: Text("No"),
                ),
                Container(
                  width: 250,
                  alignment: Alignment.centerLeft,
                  child: Text("Indikator Penilaian"),
                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  width: 150,
                  alignment: Alignment.centerLeft,
                  child: Text("Bobot Skala"),
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerLeft,
                  child: Text("Nilai"),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: pelaporanProgram.map((e) {
                  return PelaksanaanTableItem(
                      no: (pelaporanProgram.indexOf(e) + 1).toString(),
                      aspek: e.aspect,
                      detailVariable: e.variableDetail,
                      skor: e.score,
                      showBottomDivider: (pelaporanProgram.indexOf(e) + 1) ==
                          pelaporanProgram.length,
                      onChangedNilai: (val) {
                        print(val);
                        if (val.isEmpty) {
                          print("value is empty");
                          giveScore(pelaporanProgram.indexOf(e), null);
                        } else {
                          giveScore(
                              pelaporanProgram.indexOf(e), int.parse(val));
                        }
                      });
                }).toList(),
              ),
            ),
          ),
          Container(
            width: 800,
            height: 50,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(color: Colors.blueGrey),
                    top: BorderSide(color: Colors.blueGrey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Total Nilai Akhir : '),
                SizedBox(
                  width: 140,
                ),
                Text(scoreTotal.toString()),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PelaksanaanProgram extends StatefulWidget {
  const PelaksanaanProgram({super.key});

  @override
  State<PelaksanaanProgram> createState() => _PelaksanaanProgramState();
}

class _PelaksanaanProgramState extends State<PelaksanaanProgram> {
  List<Instrument> pelaksanaanProgram = DummyInstrument.pelaksanaanProgram;
  int scoreTotal = 0;
  giveScore(int index, int? value) {
    if (value == null) {
      print("Score is null");
      setState(() {
        pelaksanaanProgram[index].finalScore = null;
      });
    } else {
      setState(() {
        pelaksanaanProgram[index].finalScore = value;
      });
      getfinalScoreTotal();
    }
  }

  getfinalScoreTotal() {
    int total = 0;
    pelaksanaanProgram.forEach((element) {
      if (element.finalScore != null) {
        total += element.finalScore!;
      }
    });
    total = (total / 33 * 100).toInt();
    setState(() {
      scoreTotal = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.print_rounded,
                      color: Colors.blueGrey,
                    )),
                SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  minWidth: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  onPressed: () {},
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 800,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(15),
                //     topRight: Radius.circular(15)),
                border: Border(
                    bottom: BorderSide(color: Colors.blueGrey),
                    top: BorderSide(color: Colors.blueGrey))
                // borderRadius: BorderRadius.circular(15),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 3,
                //     offset: const Offset(
                //         -1, 1), // changes position of shadow
                //   ),
                // ],
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 20,
                  alignment: Alignment.centerLeft,
                  child: Text("No"),
                ),
                Container(
                  width: 250,
                  alignment: Alignment.centerLeft,
                  child: Text("Indikator Penilaian"),
                ),
                Container(
                  width: 150,
                  alignment: Alignment.centerLeft,
                  child: Text("Bobot Skala"),
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerLeft,
                  child: Text("Nilai"),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: pelaksanaanProgram.map((e) {
                  return PelaksanaanTableItem(
                      no: (pelaksanaanProgram.indexOf(e) + 1).toString(),
                      aspek: e.aspect,
                      detailVariable: e.variableDetail,
                      skor: e.score,
                      showBottomDivider: (pelaksanaanProgram.indexOf(e) + 1) ==
                          pelaksanaanProgram.length,
                      onChangedNilai: (val) {
                        print(val);
                        if (val.isEmpty) {
                          print("value is empty");
                          giveScore(pelaksanaanProgram.indexOf(e), null);
                        } else {
                          giveScore(
                              pelaksanaanProgram.indexOf(e), int.parse(val));
                        }
                      });
                }).toList(),
              ),
            ),
          ),
          Container(
            width: 800,
            height: 50,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(color: Colors.blueGrey),
                    top: BorderSide(color: Colors.blueGrey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Total Nilai Akhir : '),
                SizedBox(
                  width: 140,
                ),
                Text(scoreTotal.toString()),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PerencanaanProgramTable extends StatefulWidget {
  const PerencanaanProgramTable({
    super.key,
  });

  @override
  State<PerencanaanProgramTable> createState() =>
      _PerencanaanProgramTableState();
}

class _PerencanaanProgramTableState extends State<PerencanaanProgramTable> {
  List<Instrument> perencanaanProgram = DummyInstrument.perencanaanProgramA;
  int scoreTotal = 0;
  giveScore(int index, int? value) {
    if (value == null) {
      print("Score is null");
      setState(() {
        perencanaanProgram[index].finalScore = null;
      });
    } else {
      setState(() {
        perencanaanProgram[index].finalScore = value;
      });
      getfinalScoreTotal();
    }
  }

  getfinalScoreTotal() {
    int total = 0;
    perencanaanProgram.forEach((element) {
      if (element.finalScore != null) {
        total += element.finalScore!;
      }
    });
    total = (total / 33 * 100).toInt();
    setState(() {
      scoreTotal = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    'File Laporan : ',
                    style: TextStyle(color: Colors.blueGrey.shade600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 280),
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 1,
                    //     blurRadius: 3,
                    //     offset:
                    //         const Offset(-1, 1), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/pdf_file.svg',
                        height: 40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'nama_file.pdf',
                            style: TextStyle(color: Colors.teal),
                            textAlign: TextAlign.left,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Terakhir Diperbarui : ',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blueGrey.shade600),
                              ),
                              Text(
                                '24-02-2023 pukul 18.30',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blueGrey.shade600),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.print_rounded,
                          color: Colors.blueGrey,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    MaterialButton(
                      minWidth: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      onPressed: () {},
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 800,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(15),
                //     topRight: Radius.circular(15)),
                border: Border(
                    bottom: BorderSide(color: Colors.blueGrey),
                    top: BorderSide(color: Colors.blueGrey))
                // borderRadius: BorderRadius.circular(15),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 3,
                //     offset: const Offset(
                //         -1, 1), // changes position of shadow
                //   ),
                // ],
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 20,
                  alignment: Alignment.centerLeft,
                  child: Text("No"),
                ),
                Container(
                  width: 250,
                  alignment: Alignment.centerLeft,
                  child: Text("Aspek"),
                ),
                Container(
                  width: 200,
                  alignment: Alignment.centerLeft,
                  child: Text("Variabel"),
                ),
                Container(
                  width: 50,
                  alignment: Alignment.centerLeft,
                  child: Text("Skor"),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerLeft,
                  child: Text("Nilai Akhir"),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: perencanaanProgram.map((e) {
                  return TableItem(
                      no: (perencanaanProgram.indexOf(e) + 1).toString(),
                      aspek: e.aspect,
                      detailVariable: e.variableDetail,
                      skor: e.score,
                      showBottomDivider: (perencanaanProgram.indexOf(e) + 1) ==
                          perencanaanProgram.length,
                      onChangedNilai: (val) {
                        print(val);
                        if (val.isEmpty) {
                          print("value is empty");
                          giveScore(perencanaanProgram.indexOf(e), null);
                        } else {
                          giveScore(
                              perencanaanProgram.indexOf(e), int.parse(val));
                        }
                      });
                }).toList(),
              ),
            ),
          ),
          Container(
            width: 800,
            height: 50,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(color: Colors.blueGrey),
                    top: BorderSide(color: Colors.blueGrey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Total Nilai Akhir : '),
                SizedBox(
                  width: 140,
                ),
                Text(scoreTotal.toString()),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PelaksanaanTableItem extends StatefulWidget {
  PelaksanaanTableItem(
      {super.key,
      required this.no,
      required this.aspek,
      required this.detailVariable,
      required this.skor,
      this.onChangedNilai,
      this.isEmptyAction,
      this.showBottomDivider});

  final String no;
  final String aspek;
  final List<String> detailVariable;
  final List<String> skor;
  final Function(String onChanged)? onChangedNilai;
  final Function()? isEmptyAction;
  final bool? showBottomDivider;

  @override
  State<PelaksanaanTableItem> createState() => _PelaksanaanTableItemState();
}

class _PelaksanaanTableItemState extends State<PelaksanaanTableItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      width: 800,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.blueGrey.shade300))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 20,
            alignment: Alignment.center,
            child: Text(widget.no),
          ),
          Container(
            width: 300,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.aspek),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: widget.detailVariable
                      .map((e) => Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                              '${widget.detailVariable.indexOf(e) + 1}. ${e}')))
                      .toList(),
                )
              ],
            ),
          ),
          Container(
            width: 200,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.skor
                  .map((e) => Container(
                      margin: EdgeInsets.only(top: 5), child: Text(e)))
                  .toList(),
            ),
          ),
          Container(
            width: 100,
            margin: EdgeInsets.only(right: 30),
            alignment: Alignment.centerLeft,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[1-5][0,5]*'))
              ],
              onChanged: (val) {
                print(val);
                if (val.isEmpty) {
                  print("value is empty");
                  if (widget.isEmptyAction != null) {
                    widget.isEmptyAction!();
                  }
                } else {
                  if (widget.onChangedNilai != null) {
                    widget.onChangedNilai!(val);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class TableItem extends StatefulWidget {
  TableItem(
      {super.key,
      required this.no,
      required this.aspek,
      required this.detailVariable,
      required this.skor,
      this.onChangedNilai,
      this.isEmptyAction,
      this.showBottomDivider});

  final String no;
  final String aspek;
  final List<String> detailVariable;
  final List<String> skor;
  final Function(String onChanged)? onChangedNilai;
  final Function()? isEmptyAction;
  final bool? showBottomDivider;

  @override
  State<TableItem> createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      width: 800,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.blueGrey.shade300))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 20,
            alignment: Alignment.center,
            child: Text(widget.no),
          ),
          Container(
            width: 250,
            alignment: Alignment.centerLeft,
            child: Text(widget.aspek),
          ),
          SizedBox(
            width: 380,
            child: Column(
              children: widget.detailVariable.map((e) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  // decoration: BoxDecoration(
                  //     border: Border(
                  //         bottom: BorderSide(
                  //             color: Colors
                  //                 .blueGrey))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        alignment: Alignment.centerLeft,
                        child: Text(e),
                      ),
                      Container(
                        width: 50,
                        alignment: Alignment.centerLeft,
                        child:
                            Text(widget.skor[widget.detailVariable.indexOf(e)]),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            width: 100,
            margin: EdgeInsets.only(right: 30),
            alignment: Alignment.centerLeft,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[1-3][0,3]*'))
              ],
              onChanged: (val) {
                print(val);
                if (val.isEmpty) {
                  print("value is empty");
                  if (widget.isEmptyAction != null) {
                    widget.isEmptyAction!();
                  }
                } else {
                  if (widget.onChangedNilai != null) {
                    widget.onChangedNilai!(val);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
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
                  color: isSelected
                      ? Colors.blueAccent.shade100
                      : Color.fromARGB(252, 242, 242, 255),
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
        margin: EdgeInsets.symmetric(vertical: 5),
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
                            color: Colors.blueGrey.shade700, fontSize: 14),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      if (isTableNull)
                        Row(
                          children: [
                            Icon(Icons.view_quilt_rounded),
                            Text('D4 Manajemen Informatika')
                          ],
                        ),
                      if (isTableNull)
                        SizedBox(
                          height: 2,
                        ),
                      if (isTableNull) ...details,
                      if (!isTableNull)
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

// class ScoringTable extends StatefulWidget {
//   const ScoringTable({super.key});

//   @override
//   State<ScoringTable> createState() => _ScoringTableState();
// }

// class _ScoringTableState extends State<ScoringTable> {
//   @override
//   Widget build(BuildContext context) {
//     return DataTable2(
//       columnSpacing: 12,
//       horizontalMargin: 12,
//       minWidth: 600,
//       dataRowHeight: 250,
//       columns: [
//         DataColumn2(label: Text('Aspek'), fixedWidth: 150, size: ColumnSize.L),
//         DataColumn2(
//             label: Text('Variabel'), fixedWidth: 100, size: ColumnSize.L),
//         DataColumn2(label: Text('Skor'), size: ColumnSize.L),
//         DataColumn2(
//             label: Text('Unggahan Berkas'),
//             fixedWidth: 125,
//             size: ColumnSize.L),
//         DataColumn2(
//             label: Text('Validasi Dosen'), fixedWidth: 125, size: ColumnSize.L),
//         DataColumn2(label: Text('Skor Akhir'), size: ColumnSize.L),
//       ],
//       rows: [
//         DataRow(cells: [
//           DataCell(SizedBox(
//             height: 250,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text('1. Proposal'),
//                 Container(
//                     margin: EdgeInsets.only(top: 20, left: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('Nama Kegiatan')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('Latar Belakang')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('Tujuan')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('Tema')),
//                       ],
//                     ))
//               ],
//             ),
//           )),
//           DataCell(SizedBox(
//             height: 250,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text('10 Unsur'),
//                 Container(
//                     margin: EdgeInsets.only(top: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('4 Unsur')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('7 Unsur')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('2 Unsur')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('3 Unsur')),
//                       ],
//                     ))
//               ],
//             ),
//           )),
//           DataCell(SizedBox(
//             height: 250,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text('5'),
//                 Container(
//                     margin: EdgeInsets.only(top: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('4')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('3')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('2')),
//                         Container(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: Text('1')),
//                       ],
//                     ))
//               ],
//             ),
//           )),
//           DataCell(SizedBox(
//             height: 250,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   'assets/icons/pdf_file.svg',
//                   height: 25,
//                 ),
//                 Text('Proposal.pdf'),
//               ],
//             ),
//           )),
//           DataCell(SizedBox(
//             height: 250,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Checkbox(value: false, onChanged: (isTrue) {}),
//                 Container(
//                     margin: EdgeInsets.only(top: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Checkbox(value: false, onChanged: (isTrue) {}),
//                         Checkbox(value: false, onChanged: (isTrue) {}),
//                         Checkbox(value: false, onChanged: (isTrue) {}),
//                         Checkbox(value: false, onChanged: (isTrue) {}),
//                       ],
//                     ))
//               ],
//             ),
//           )),
//           DataCell(Container(
//               height: 250,
//               width: 150,
//               alignment: Alignment.center,
//               child: const Text('5'))),
//         ])
//       ],
//       // rows: List<DataRow>.generate(
//       //     100,
//       //     (index) => DataRow(cells: [
//       //           DataCell(Text('A' * (10 - index % 10))),
//       //           DataCell(Text('B' * (10 - (index + 5) % 10))),
//       //           DataCell(Text('C' * (15 - (index + 5) % 10))),
//       //         ]))
//     );
//   }
// }

class PerencanaanProgramA extends StatefulWidget {
  const PerencanaanProgramA({super.key});

  @override
  State<PerencanaanProgramA> createState() => _PerencanaanProgramAState();
}

class _PerencanaanProgramAState extends State<PerencanaanProgramA> {
  List<Instrument> perencanaanProgramA = DummyInstrument.perencanaanProgramA;
  int scoreTotal = 0;

  giveScore(int index, int? value) {
    if (value == null) {
      print("Score is null");
      setState(() {
        perencanaanProgramA[index].finalScore = null;
      });
    } else {
      setState(() {
        perencanaanProgramA[index].finalScore = value;
      });
      getfinalScoreTotal();
    }
  }

  getfinalScoreTotal() {
    int total = 0;
    perencanaanProgramA.forEach((element) {
      if (element.finalScore != null) {
        total += element.finalScore!;
      }
    });
    total = (total / 33 * 100).toInt();
    setState(() {
      scoreTotal = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          dataRowHeight: 250,
          showBottomBorder: true,
          columns: [
            DataColumn2(label: Text('No'), fixedWidth: 50, size: ColumnSize.M),
            DataColumn2(
                label: Text('Aspek'), fixedWidth: 200, size: ColumnSize.L),
            DataColumn2(
                label: Text('Variabel Penilaian dan Skor'),
                fixedWidth: 270,
                size: ColumnSize.L),
            // DataColumn2(label: Text('Skor'), fixedWidth: 50, size: ColumnSize.M),
            DataColumn2(
                label: Text('Skor Penilaian Variabel'),
                fixedWidth: 200,
                size: ColumnSize.S),
          ],
          rows: perencanaanProgramA
              .map((e) => DataRow(cells: [
                    DataCell(
                        Text((perencanaanProgramA.indexOf(e) + 1).toString())),
                    DataCell(Text(e.aspect)),
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: e.variableDetail
                          .map((element) => SizedBox(
                                width: 270,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            element,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Text(e.score[
                                            e.variableDetail.indexOf(element)])
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Expanded(
                                          child: Divider(
                                            color: Colors.black26,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    )),
                    // DataCell(Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: e.score
                    //       .map((element) => SizedBox(
                    //             height: 80,
                    //             child: Column(
                    //               children: [
                    //                 Text(element),
                    //                 Row(
                    //                   children: const [
                    //                     Expanded(
                    //                       child: Divider(
                    //                         color: Colors.black26,
                    //                       ),
                    //                     )
                    //                   ],
                    //                 )
                    //               ],
                    //             ),
                    //           ))
                    //       .toList(),
                    // )),
                    DataCell(Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-3][0,3]*'))
                        ],
                        onChanged: (val) {
                          print(val);
                          if (val.isEmpty) {
                            print("value is empty");
                            giveScore(perencanaanProgramA.indexOf(e), null);
                          } else {
                            giveScore(
                                perencanaanProgramA.indexOf(e), int.parse(val));
                          }
                        },
                      ),
                    ))
                  ]))
              .toList(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            color: Color.fromARGB(252, 242, 242, 255),
            width: 220,
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Total Skor Penilaian Variabel : "),
                    Text(scoreTotal.toString())
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class PelaksanaanProgram extends StatefulWidget {
//   const PelaksanaanProgram({super.key});

//   @override
//   State<PelaksanaanProgram> createState() => _PelaksanaanProgramState();
// }

// class _PelaksanaanProgramState extends State<PelaksanaanProgram> {
//   List<Instrument> perencanaanProgramA = DummyInstrument.perencanaanProgramA;
//   int scoreTotal = 0;

//   giveScore(int index, int? value) {
//     if (value == null) {
//       print("Score is null");
//       setState(() {
//         perencanaanProgramA[index].finalScore = null;
//       });
//     } else {
//       setState(() {
//         perencanaanProgramA[index].finalScore = value;
//       });
//       getfinalScoreTotal();
//     }
//   }

//   getfinalScoreTotal() {
//     int total = 0;
//     perencanaanProgramA.forEach((element) {
//       if (element.finalScore != null) {
//         total += element.finalScore!;
//       }
//     });
//     total = (total / 33 * 100).toInt();
//     setState(() {
//       scoreTotal = total;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           minWidth: 600,
//           dataRowHeight: 250,
//           showBottomBorder: true,
//           columns: [
//             DataColumn2(label: Text('No'), fixedWidth: 50, size: ColumnSize.M),
//             DataColumn2(
//                 label: Text('Aspek'), fixedWidth: 200, size: ColumnSize.L),
//             DataColumn2(
//                 label: Text('Variabel Penilaian dan Skor'),
//                 fixedWidth: 270,
//                 size: ColumnSize.L),
//             // DataColumn2(label: Text('Skor'), fixedWidth: 50, size: ColumnSize.M),
//             DataColumn2(
//                 label: Text('Skor Penilaian Variabel'),
//                 fixedWidth: 200,
//                 size: ColumnSize.S),
//           ],
//           rows: perencanaanProgramA
//               .map((e) => DataRow(cells: [
//                     DataCell(
//                         Text((perencanaanProgramA.indexOf(e) + 1).toString())),
//                     DataCell(Text(e.aspect)),
//                     DataCell(Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: e.variableDetail
//                           .map((element) => SizedBox(
//                                 width: 270,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         SizedBox(
//                                           width: 200,
//                                           child: Text(
//                                             element,
//                                             textAlign: TextAlign.left,
//                                           ),
//                                         ),
//                                         Text(e.score[
//                                             e.variableDetail.indexOf(element)])
//                                       ],
//                                     ),
//                                     Row(
//                                       children: const [
//                                         Expanded(
//                                           child: Divider(
//                                             color: Colors.black26,
//                                           ),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ))
//                           .toList(),
//                     )),
//                     // DataCell(Column(
//                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: e.score
//                     //       .map((element) => SizedBox(
//                     //             height: 80,
//                     //             child: Column(
//                     //               children: [
//                     //                 Text(element),
//                     //                 Row(
//                     //                   children: const [
//                     //                     Expanded(
//                     //                       child: Divider(
//                     //                         color: Colors.black26,
//                     //                       ),
//                     //                     )
//                     //                   ],
//                     //                 )
//                     //               ],
//                     //             ),
//                     //           ))
//                     //       .toList(),
//                     // )),
//                     DataCell(Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 50),
//                       child: TextField(
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(
//                               RegExp(r'^[1-3][0,3]*'))
//                         ],
//                         onChanged: (val) {
//                           print(val);
//                           if (val.isEmpty) {
//                             print("value is empty");
//                             giveScore(perencanaanProgramA.indexOf(e), null);
//                           } else {
//                             giveScore(
//                                 perencanaanProgramA.indexOf(e), int.parse(val));
//                           }
//                         },
//                       ),
//                     ))
//                   ]))
//               .toList(),
//         ),
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: Container(
//             color: Color.fromARGB(252, 242, 242, 255),
//             width: 220,
//             height: 40,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     Text("Total Skor Penilaian Variabel : "),
//                     Text(scoreTotal.toString())
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
