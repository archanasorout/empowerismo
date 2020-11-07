
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/search_remaining_model.dart';
import 'package:empowerismo/base/repo/language_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'BlocBase.dart';

class LanguageBloc implements BlocBase {
  var languageModel = BehaviorSubject<LanguageModel>();
   var repo = LanguageRepo();

  getLanguage(BuildContext context,) async {
    languageModel.sink.add(await repo.getLanguage(context));
  }
  Future<LanguageModel> returnLanguageData(BuildContext context,) async {
     return await repo.getLanguage(context,);
  }

  Future<SearchRemainingModel> searchRemaining(String authToken,BuildContext context,) async {
     return await repo.searchRemainingApi(authToken,context,);
  }
  get stream => languageModel.stream;


  @override
  void dispose() {
    languageModel.close();


  }
}
