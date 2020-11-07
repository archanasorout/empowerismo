import 'package:empowerismo/base/model/add_to_fav_model.dart';
import 'package:empowerismo/base/model/create_new_list_model.dart';
import 'package:empowerismo/base/model/delete_model.dart';
import 'package:empowerismo/base/model/get_favourite_list_model.dart';
import 'package:empowerismo/base/model/rename_fav_model.dart';
import 'package:empowerismo/base/model/select_word_model.dart';
import 'package:empowerismo/base/model/unfavourite_model.dart';
import 'package:empowerismo/base/repo/favourite_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class FavouriteBloc {
  var favouriteModelbloc = BehaviorSubject<FavouriteModel>();
  var repo = FavouriteRepo();

  Future<CreateNewListModel> createNewListResponse(BuildContext context,
      {String name, String color, String authToken}) async {
    return await repo.createNewList(
        context,
      list_name: name,
      color: color,
      auth_token: authToken,
    );
  }

  getFavouritelist(BuildContext context,{String id, String auth_token}) async {
    favouriteModelbloc.add(await repo.getFavouriteListModel(
      context,
      id: id,
      auth_token: auth_token,
    ));
  }

  Future<DeleteModal> deleteFavList(BuildContext context,{String id, String auth_token}) async {
    return await repo.deleteFromFavList(context,id: id, auth_token: auth_token);
  }

  Future<UnFavouriteModel> removeWordFromFavList(BuildContext context,{
    String list_id,
    String word_id,
    String auth_token,
  }) async {
    return await repo.removeWordFromApi(
        context,
        list_id: list_id, word_id: word_id, auth_token: auth_token);
  }

  Future<AddToFavListModel> addToFavList(
      BuildContext context,
      {String auth_token,
      ResultOfSelectWord resultOfSelectWord,
      String list_id}) async {
    return await repo.addInFavList(
        context,
      list_id: list_id,
      auth_token: auth_token,
      resultOfSelectWord: resultOfSelectWord,
    );
  }

  Future<RenameFavListModel> renameFavList(BuildContext context,
      {String id, String auth_token, String name, String color}) async {
    return await repo.renameFavList(context,
        id: id, auth_token: auth_token, name: name, color: color);
  }

  get stream => favouriteModelbloc.stream;

  get sink => favouriteModelbloc.sink;

  @override
  void dispose() {
    favouriteModelbloc.close();
  }
}
