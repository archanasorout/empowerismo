import 'package:empowerismo/base/model/search_word_model.dart';
import 'package:empowerismo/base/model/select_word_model.dart';
import 'package:empowerismo/base/repo/search_word_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class SearchWordBloc{
  var searchWordModel = BehaviorSubject<SearchWordModel>();
   var repo = SearchWordRepo();

    getSearchWord(BuildContext context,{String target_language,String search_word,String auth_token}) async {
    searchWordModel.sink.add(await repo.searchWord(context,target_language: target_language,search_word:search_word,auth_token:auth_token ));
  }

  get stream => searchWordModel.stream;


  @override
  void dispose() {
    searchWordModel.close();


  }
}
