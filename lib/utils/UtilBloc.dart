import 'package:empowerismo/base/bloc/BlocBase.dart';
import 'package:empowerismo/enums/ScreenType.dart';
import 'package:flutter/cupertino.dart';
 import 'package:rxdart/rxdart.dart';

class UtilBloc implements BlocBase {
  var stringBloc = BehaviorSubject<String>();
  var intBloc = BehaviorSubject<int>();
  var boolBloc = BehaviorSubject<bool>();
  var screenType = BehaviorSubject<ScreenType>();
  var listTypee = BehaviorSubject<Widget>();

  string({String value}) {
    stringBloc.add(value);
  }

  integer({int value}) {
    intBloc.add(value);
  }
  type({ScreenType type}) {
    screenType.add(type);
  }

  booll({bool value}) {
    boolBloc.add(value);
  }

  @override
  void dispose() {}
}
