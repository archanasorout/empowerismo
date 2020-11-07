import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/repo/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'BlocBase.dart';


class ProfileBloc<T> implements BlocBase {

  final ListOfChanges = PublishSubject<List<T>>();

  var repo = ProfileRepo();

  Future<LoginModel> updateProfile(BuildContext context,{  String name,String id,String authToken,String image}) async {
    return await repo.updateProfile(context,name: name,id: id,auth_token: authToken,image:image);
  }

  get stream => ListOfChanges.stream;

  get sink => ListOfChanges.sink;

  @override
  void dispose() {
    ListOfChanges.close();
  }
}
