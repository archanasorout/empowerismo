import 'package:rxdart/rxdart.dart';

import 'BlocBase.dart';


class ColorBloc<T> implements BlocBase {

  final ListOfColor = PublishSubject<List<T>>();


  get stream => ListOfColor.stream;

  get sink => ListOfColor.sink;

  @override
  void dispose() {
    ListOfColor.close();
  }
}
