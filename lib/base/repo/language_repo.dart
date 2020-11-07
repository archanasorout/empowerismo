
import 'package:empowerismo/base/BaseRepository.dart';
import 'package:empowerismo/base/constants/ApiEndpoint.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/model/search_remaining_model.dart';
import 'package:empowerismo/base/network/ApiHitter.dart';
import 'package:flutter/cupertino.dart';
class LanguageRepo extends BaseRepository {

    Future<LanguageModel> getLanguage(BuildContext context,) async {
    ApiResponse apiResponse = await apiHitter.getApiResponse(
      ApiEndpoint.GET_LANGUAGE,

        context,
      khase: "get language data"
    );
    if (apiResponse?.status) {
      return LanguageModel.fromJson(apiResponse.response.data);
    } else {
      return LanguageModel(responseCode: 401,responseMessage: apiResponse?.msg);
    }
  }
  Future<SearchRemainingModel> searchRemainingApi(String authToken,BuildContext context,) async {
    ApiResponse apiResponse = await apiHitter.getApiResponse(
      ApiEndpoint.SEARCH_REMAINING,
          context,
      khase: "SEARCH_REMAINING",
      headers: {
        "auth_token":authToken
      }
    );
    if (apiResponse?.status) {
      return SearchRemainingModel.fromJson(apiResponse.response.data);
    } else {
      return SearchRemainingModel(responseCode: 401,responseMessage: apiResponse?.msg);
    }
  }

}
