import 'package:empowerismo/utils/Theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

extension Utility on String {
  toast({Color color:purpleColor}) =>
      Fluttertoast.showToast(
        msg: this,
        textColor: color,
        toastLength: Toast.LENGTH_SHORT,
      );
}

extension TextFeild on TextEditingController {
  String value() => this.text.toString();
}

extension douuble on double {
}

extension Integer on int {
  delay(Function function) {
    Future.delayed(Duration(seconds: this), () {
      function();
    });
  }


marginLeftRightTopBottom(int left,int right)
{
  return EdgeInsets.only(left: left.toDouble(),right:right.toDouble());
}



  horizontalSpace() =>
    SizedBox(width : this.toDouble());

  verticalSpace() =>
      SizedBox(height: this.toDouble());

  toast() =>
      Fluttertoast.showToast(
        msg: this.toString(),
        toastLength: Toast.LENGTH_SHORT,
      );

  loop(Function function) {
    for (var i = 0; i < this; i++) {
      function(i);
    }
  }

  paddingLeft() {
    return EdgeInsets.only(left: this.toDouble());
  }

  paddingAll() {
    return EdgeInsets.all(this.toDouble());
  }

  paddingRight() {
    return EdgeInsets.only(right: this.toDouble());
  }

  paddingHorizontal() {
    return EdgeInsets.only(top: this.toDouble(), bottom: this.toDouble());
  }

  paddingVertical() {
    return EdgeInsets.only(left: this.toDouble(), right: this.toDouble());
  }

  marginAll() {
    return EdgeInsets.all(this.toDouble());
  }

  marginLeft() {
    return EdgeInsets.only(left: this.toDouble());
  }

  marginRight() {
    return EdgeInsets.only(right: this.toDouble());
  }

  marginHorizontal() {
    return EdgeInsets.only(top: this.toDouble(), bottom: this.toDouble());
  }

  marginVertical() {
    return EdgeInsets.only(left: this.toDouble(), right: this.toDouble());
  }
}
extension OnWidget on BuildContext{

  pop() {
    Navigator.pop(this);
  }
}
extension ColorExtension on String {
toColor() {
  var hexColor = this.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}
}
extension marginOrPaddingOnly on Widget{

marginRight(int right ,int left) {
  return EdgeInsets.only(right: right.toDouble(),left:left.toDouble() );
}
}