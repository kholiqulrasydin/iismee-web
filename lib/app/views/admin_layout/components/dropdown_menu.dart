import 'package:flutter/material.dart';

class GesturedDropDown extends StatefulWidget {
  GesturedDropDown({super.key, required this.values, this.isHasValue = true, this.icon = const Icon(Icons.keyboard_arrow_down_rounded)});

  final Widget icon;
  final bool isHasValue;
  final List<ItemMenu> values;
  @override
  State<GesturedDropDown> createState() => _GesturedDropDownState();
}

class _GesturedDropDownState extends State<GesturedDropDown> {
  List<ItemMenu> list = [];
  ItemMenu dropdownValue = ItemMenu(onTap: () {  }, title: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.values;
    dropdownValue = widget.values.first;
  }

  @override
  Widget build(BuildContext context) {
    if( !widget.isHasValue){
      return PopupMenuButton<ItemMenu>(
          icon: widget.icon,
          onSelected: (selectedItem) {
            if(selectedItem.onTap != null){
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
      style: widget.isHasValue ? TextStyle(color: Colors.blueGrey.shade700) : null,
      underline: widget.isHasValue ? Container(
        height: 2,
        color: Colors.blueAccent.shade700,
      ) : null,
      onChanged: (ItemMenu? value) => value  ,
      items: list.map<DropdownMenuItem<ItemMenu>>((ItemMenu value) {
        return DropdownMenuItem<ItemMenu>(
          value: value,
          child: Text(value.title),
        );
      }).toList(),
    );
  }
}

class ItemMenu{
  final String title;
  final Function()? onTap;

  ItemMenu({required this.title, required this.onTap});
  
}