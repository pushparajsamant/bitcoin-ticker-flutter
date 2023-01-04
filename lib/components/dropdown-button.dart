import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatefulWidget {
  final List<String> items;

  DropDownButtonWidget({required this.items});

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButtonWidget> {
  String dropdownValue = "";

  CupertinoPicker getCupertinoDropDown() {
    List<Text> listItems = [];
    for (String item in widget.items) {
      listItems.add(Text(item));
    }
    return CupertinoPicker(
      backgroundColor: Colors.blue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          dropdownValue = widget.items[selectedIndex];
          //print(dropdownValue);
        });
      },
      children: listItems,
    );
  }

  DropdownButton getDropDownButton() {
    return DropdownButton(
      value: dropdownValue,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          dropdownValue = value!;
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return getDropDownButton();
    } else {
      return getCupertinoDropDown();
    }
  }
}
