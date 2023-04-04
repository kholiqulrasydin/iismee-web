import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ButtonDropdown extends StatefulWidget {
  const ButtonDropdown({super.key});

  @override
  State<ButtonDropdown> createState() => _ButtonDropdownState();
}

class _ButtonDropdownState extends State<ButtonDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Container(
          width: 90,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(-1, 1), // changes position of shadow
                ),
              ]),
          alignment: Alignment.center,
          child: Text(
            'Aksi',
            style: TextStyle(color: Colors.white),
          ),
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem);
        },
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 48),
            8,
            ...List<double>.filled(MenuItems.secondItems.length, 48),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
          height: 48,
        ),
        dropdownStyleData: DropdownStyleData(
            width: 160,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            elevation: 8,
            offset: const Offset(0, 8)),
      ),
    );
  }
}

class MenuItems {
  static const List<MenuItem> firstItems = [logbook, presensi];
  static const List<MenuItem> secondItems = [nilaiMpk];

  static const logbook =
      MenuItem(text: 'Logbook', icon: Icons.library_books_rounded);
  static const presensi =
      MenuItem(text: 'Presensi', icon: Icons.people_alt_outlined);
  // static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const nilaiMpk = MenuItem(text: 'Nilai MPK', icon: Icons.note_rounded);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.blueGrey, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: TextStyle(
            color: Colors.blueGrey.shade600,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.logbook:
        //Do something
        break;
      // case MenuItems.settings:
      //   //Do something
      //   break;
      case MenuItems.presensi:
        //Do something
        break;
      case MenuItems.nilaiMpk:
        //Do something
        break;
    }
  }
}

class MenuItem {
  final String text;
  final IconData icon;
  final Function()? onPressed;

  const MenuItem({required this.text, required this.icon, this.onPressed});
}

class GesturedDropDown extends StatefulWidget {
  GesturedDropDown(
      {super.key,
      required this.values,
      this.isHasValue = true,
      this.icon = const Icon(Icons.keyboard_arrow_down_rounded)});

  final Widget icon;
  final bool isHasValue;
  final List<ItemMenu> values;
  @override
  State<GesturedDropDown> createState() => _GesturedDropDownState();
}

class _GesturedDropDownState extends State<GesturedDropDown> {
  List<ItemMenu> list = [];
  ItemMenu dropdownValue = ItemMenu(onTap: () {}, title: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.values;
    dropdownValue = widget.values.first;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isHasValue) {
      return PopupMenuButton<ItemMenu>(
        icon: widget.icon,
        onSelected: (selectedItem) {
          if (selectedItem.onTap != null) {
            selectedItem.onTap!();
          }
        },
        itemBuilder: (BuildContext context) {
          return list.map((ItemMenu choice) {
            return PopupMenuItem<ItemMenu>(
              value: choice,
              child: Text(choice.title),
            );
          }).toList();
        },
      );
    }
    return DropdownButton<ItemMenu>(
      value: widget.isHasValue ? dropdownValue : null,
      icon: widget.icon,
      elevation: widget.isHasValue ? 16 : 0,
      style:
          widget.isHasValue ? TextStyle(color: Colors.blueGrey.shade700) : null,
      underline: widget.isHasValue
          ? Container(
              height: 2,
              color: Colors.blueAccent.shade700,
            )
          : null,
      onChanged: (ItemMenu? value) => value,
      items: list.map<DropdownMenuItem<ItemMenu>>((ItemMenu value) {
        return DropdownMenuItem<ItemMenu>(
          value: value,
          child: Text(value.title),
        );
      }).toList(),
    );
  }
}

class AksiDropdown extends StatefulWidget {
  AksiDropdown({
    super.key,
    required this.values,
    this.isHasValue = true,
    this.width = 100,
    this.height = 70,
  });

  final double? width;
  final double? height;
  final bool isHasValue;
  final List<ItemMenu> values;
  @override
  State<AksiDropdown> createState() => _AksiDropdownState();
}

class _AksiDropdownState extends State<AksiDropdown> {
  List<ItemMenu> list = [];
  ItemMenu dropdownValue = ItemMenu(onTap: () {}, title: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.values;
    dropdownValue = widget.values.first;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isHasValue) {
      return PopupMenuButton<ItemMenu>(
        child: Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('Aksi'),
        ),
        onSelected: (selectedItem) {
          if (selectedItem.onTap != null) {
            selectedItem.onTap!();
          }
        },
        itemBuilder: (BuildContext context) {
          return list.map((ItemMenu choice) {
            return PopupMenuItem<ItemMenu>(
              value: choice,
              child: Text(choice.title),
            );
          }).toList();
        },
      );
    }
    return DropdownButton<ItemMenu>(
      value: widget.isHasValue ? dropdownValue : null,
      elevation: widget.isHasValue ? 16 : 0,
      style:
          widget.isHasValue ? TextStyle(color: Colors.blueGrey.shade700) : null,
      underline: widget.isHasValue
          ? Container(
              height: 2,
              color: Colors.blueAccent.shade700,
            )
          : null,
      onChanged: (ItemMenu? value) => value,
      items: list.map<DropdownMenuItem<ItemMenu>>((ItemMenu value) {
        return DropdownMenuItem<ItemMenu>(
          value: value,
          child: Text(value.title),
        );
      }).toList(),
    );
  }
}

class ItemMenu {
  final String title;
  final Function()? onTap;

  ItemMenu({required this.title, required this.onTap});
}
