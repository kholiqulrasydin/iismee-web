import 'package:flutter/material.dart';

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
                  color: isSelected ? Colors.blueAccent.shade100 : Colors.white,
                  borderRadius: BorderRadius.circular(15)),
            )
          ],
        ),
      ),
    );
  }
}