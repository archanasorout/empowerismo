import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:flutter/material.dart';


class CustomDropDown extends StatefulWidget {
  List<dynamic> list;
  String hint;
  Function onChanged;

  CustomDropDown(
      {this.list = const [], this.hint = "Hint Here", this.onChanged(String)});

  @override
  _CustomDropDownState createState() => _CustomDropDownState(initValue: list[0]);
}

class _CustomDropDownState extends State<CustomDropDown> {
  var initValue;

  _CustomDropDownState({this.initValue='a'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton(
            dropdownColor: colorWhite,
            elevation: 16,
            value: initValue,
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
            underline: SizedBox(),
            items: widget.list
                .map((e) => DropdownMenuItem(
                value: e,
                child: Padding(
                  padding: 8.paddingHorizontal(),
                  child: new Text(
                    e,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )))
                .toList(),
            hint: new Text(
              widget.hint,
              style: TextStyle(color: colorBlack),
            ),
            onChanged: (value) {
              setState(() {
                initValue = value;
                widget.onChanged(value);
              });
            }),
        Divider(
          color: lightGrey,
          height: 4,
          thickness: 1.0,
        )
      ],
    );
  }
}