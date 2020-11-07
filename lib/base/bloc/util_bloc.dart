  import 'package:empowerismo/enums/ScreenType.dart';
import 'package:rxdart/rxdart.dart';

import 'BlocBase.dart';

class UtilBloc implements BlocBase {
  var stringBloc = BehaviorSubject<String>();
  var intBloc = BehaviorSubject<int>();
  var boolBloc = BehaviorSubject<bool>();
  var screenType = BehaviorSubject<ScreenType>();

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
