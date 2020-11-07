import 'package:empowerismo/base/BaseRepository.dart';
import 'package:empowerismo/base/constants/ApiEndpoint.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/search_word_model.dart';
import 'package:empowerismo/base/model/select_word_model.dart';
 import 'package:empowerismo/base/network/ApiHitter.dart';
import 'package:flutter/cupertino.dart';
class SearchWordRepo extends BaseRepository {

  Future<SearchWordModel> searchWord(BuildContext context,{String target_language,String search_word,String auth_token}) async {
    ApiResponse apiResponse = await apiHitter.getApiResponse(
        ApiEndpoint.SEARCH_WORD+target_language+"/like/"+search_word,
          context,
        khase:"SearchWordRepo",
      headers: {
          "auth_token":auth_token,
      }

     );
    if (apiResponse.status) {
      return SearchWordModel.fromJson(apiResponse.response.data);
    } else {
      return SearchWordModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }

  Future<SelectWordModel> selectWord(BuildContext context,{String target_language,String search_word,String auth_token}) async {
    ApiResponse apiResponse = await apiHitter.getApiResponse(
        ApiEndpoint.SEARCH_WORD+target_language+"/"+search_word,
          context,
        khase:"SearchWordRepo22",
      headers: {
          "auth_token":auth_token
      }


     );
    if (apiResponse!=null && apiResponse?.status) {
      return SelectWordModel.fromJson(apiResponse.response.data);
    } else {
      return SelectWordModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }

}
