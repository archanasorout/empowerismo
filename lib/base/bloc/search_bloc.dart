import 'package:empowerismo/base/model/select_word_model.dart';
import 'package:empowerismo/base/repo/search_word_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'BlocBase.dart';

class SearchBloc<T> implements BlocBase {
  final selectWordBloc = PublishSubject<SelectWordModel>();

  var repo = SearchWordRepo();
//  get stream => bloc.stream;
 //  get sink => bloc.sink;

 // final bloc = PublishSubject<List<T>>();

    getSelectedWord(BuildContext context,{String target_language,String search_word,String auth_token}) async {
      selectWordBloc.sink.add(
    await repo.selectWord(context,target_language: target_language,search_word:search_word,auth_token: auth_token )
    );
  }


  @override
  void dispose() {
    selectWordBloc.close();
  }
}
