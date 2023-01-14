import 'package:flutter/material.dart';
import 'package:iismee/app/controllers/size_controller.dart';

class ContentCheckbox extends StatefulWidget {
  ContentCheckbox({super.key, required this.sizeControl, this.margin, required this.question, this.onChanged, required this.answer});
  final SizeController sizeControl;
  final EdgeInsetsGeometry? margin;
  final Widget question;
  final Widget answer;
  final Function(bool? value)? onChanged;

  @override
  State<ContentCheckbox> createState() => _ContentCheckboxState();
}

class _ContentCheckboxState extends State<ContentCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: widget.sizeControl.getWidthFromPrecentage(
                widget.sizeControl.isLargeScreen.value ? 12 : 55),
            child: widget.question,
          ),
          SizedBox(
            width: widget.sizeControl.getWidthFromPrecentage(
                widget.sizeControl.isLargeScreen.value ? 5 : 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Checkbox(value: false, onChanged: widget.onChanged),
                widget.answer
              ],
            ),
          )
        ],
      ),
    );
  }
}
