import 'package:rxdart/rxdart.dart';

import 'BlocBase.dart';

class DashBoardBloc<T> implements BlocBase {
//List<int> indexList=new List();
  final bloc = BehaviorSubject<int>();


  get stream => bloc.stream;

  get sink => bloc.sink;

  @override
  void dispose() {
    bloc.close();
  }
}
