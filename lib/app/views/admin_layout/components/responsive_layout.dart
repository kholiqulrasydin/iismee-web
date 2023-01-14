import 'package:flutter/material.dart';


class ResponsiveRowToColumn extends StatelessWidget {
  const ResponsiveRowToColumn(
      {super.key,
      required this.condition,
      required this.children,
      this.rowMainAxisAlignment,
      this.columnMainAxisAlignment,
      this.rowCrossAxisAlignment,
      this.columnCrossAxisAlignment});

  final bool condition;
  final List<Widget> children;
  final MainAxisAlignment? rowMainAxisAlignment;
  final MainAxisAlignment? columnMainAxisAlignment;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  final CrossAxisAlignment? columnCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return condition
        ? Row(
            mainAxisAlignment: rowMainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                rowCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: children,
          )
        : Column(
            mainAxisAlignment:
                columnMainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                columnCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: children,
          );
  }
}