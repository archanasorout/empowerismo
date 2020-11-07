import 'package:empowerismo/base/BaseRepository.dart';
import 'package:empowerismo/base/constants/ApiEndpoint.dart';
import 'package:empowerismo/base/model/add_to_fav_model.dart';
import 'package:empowerismo/base/model/create_new_list_model.dart';
import 'package:empowerismo/base/model/delete_model.dart';
import 'package:empowerismo/base/model/export_word_model.dart';
import 'package:empowerismo/base/model/get_favourite_list_model.dart';
import 'package:empowerismo/base/model/rename_fav_model.dart';
import 'package:empowerismo/base/model/select_word_model.dart';
import 'package:empowerismo/base/model/unfavourite_model.dart';
 import 'package:empowerismo/base/network/ApiHitter.dart';
import 'package:flutter/cupertino.dart';


class FavouriteRepo extends BaseRepository {

  Future<CreateNewListModel> createNewList(BuildContext context,{String list_name,String color,String auth_token}) async {
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
      ApiEndpoint.CREATE_NEW_LIST,
        context,
      data: {
        "list_name":list_name,
        "label_color":color,
            }, headers: {
      "auth_token":auth_token
                  }
      );
    if (apiResponse.status) {
       return CreateNewListModel.fromJson(apiResponse.response.data);
    } else {
      return CreateNewListModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }
  Future<FavouriteModel> getFavouriteListModel(BuildContext context,{String id,String auth_token}) async {

    ApiResponse apiResponse = await apiHitter.getApiResponse(
        ApiEndpoint.UPDATE_PROFILE+"/"+id+"/fav-lists",
          context,
      khase: "fav-lists",
      headers: {
          "auth_token":auth_token
      }

    );

    if (apiResponse.status) {
      return FavouriteModel.fromJson(apiResponse.response.data);
    } else {
      return FavouriteModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }
  Future<AddToFavListModel> addInFavList(BuildContext context,{String list_id, String auth_token,
    ResultOfSelectWord resultOfSelectWord
  }) async {

    debugPrint("resultOfSelectWord.sId"+resultOfSelectWord.sId.toString());
    debugPrint("list_id"+list_id.toString());
    debugPrint("auth_token"+auth_token.toString());
    /* debugPrint("idd "+resultOfSelectWord.sId);
    debugPrint("sourceLang "+resultOfSelectWord.sourceLang);
    debugPrint("targetLang "+resultOfSelectWord.targetLang);
    debugPrint("translation "+resultOfSelectWord.translation);
    debugPrint("word "+resultOfSelectWord.word);  */
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
        ApiEndpoint.ADD_TO_FAV,
        context,
        data: {
          "list_id":list_id,
          "word_id":resultOfSelectWord.sId,
          "source_lang":resultOfSelectWord.sourceLang,
          "target_lang":resultOfSelectWord.targetLang,
          "translation":resultOfSelectWord.translation,
          "word":resultOfSelectWord.word
        },
        headers: {
          "auth_token":auth_token
        }

    );
    debugPrint("apiResponse.status"+apiResponse.msg.toString());
    if (apiResponse.status) {
      return AddToFavListModel.fromJson(apiResponse.response.data);
    } else {
      return AddToFavListModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }

  Future<ExportWordModel> exportWordApi(
      BuildContext context,{String auth_token,
String word_Id  }) async {
    debugPrint("resultOfSelectWord.sId"+word_Id);
    debugPrint("auth_token"+auth_token.toString());
    ApiResponse apiResponse = await apiHitter.getApiResponse(
        ApiEndpoint.EXPORT_WORD+word_Id,
        context, headers: {"auth_token":auth_token});
    debugPrint("apiResponse.status"+apiResponse.toString());
    if (apiResponse.status) {
      return ExportWordModel.fromJson(apiResponse.response.data);
    } else {
      return ExportWordModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }


  Future<DeleteModal> deleteFromFavList(BuildContext context,{String id,String auth_token}) async {
    ApiResponse apiResponse = await apiHitter.deleteApiResponse(
        ApiEndpoint.DELETE_FROM_API+"/"+id,
        context,
      headers: {"auth_token":auth_token,},
    );
    if (apiResponse.status) {
      return DeleteModal.fromJson(apiResponse.response.data);
    } else {return DeleteModal(responseCode: 401,responseMessage: apiResponse.msg);}
  }

  Future<UnFavouriteModel> removeWordFromApi(BuildContext context,{String list_id,String word_id, String auth_token}) async {
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
        ApiEndpoint.UNFAVOURITE, context,
      data:
      {
          "list_id":list_id ,
          "word_id":word_id ,
      },
      headers: {"auth_token": auth_token,},
    );
    if (apiResponse.status) {
      return UnFavouriteModel.fromJson(apiResponse.response.data);
    } else {return UnFavouriteModel(responseCode: 401,responseMessage: apiResponse.msg);}
  }

  Future<RenameFavListModel> renameFavList(BuildContext context,{String id,String auth_token,String name,String color}) async {
    ApiResponse apiResponse = await apiHitter.getPutApiResponse(
        ApiEndpoint.DELETE_FROM_API+"/"+id,
       context,
      data: {
          "list_name":name,
          "label_color":color,
      },
      headers: {"auth_token":auth_token,},
    );
    if (apiResponse.status) {
      return RenameFavListModel.fromJson(apiResponse.response.data);
    } else {return RenameFavListModel(responseCode: 401,responseMessage: apiResponse.msg);}
  }


}
