
import 'package:empowerismo/base/BaseRepository.dart';
import 'package:empowerismo/base/constants/ApiEndpoint.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/network/ApiHitter.dart';
import 'package:flutter/cupertino.dart';
class ProfileRepo extends BaseRepository {

  Future<LoginModel> updateProfile(BuildContext context,{String name,String id,String auth_token,String image}) async {

    ApiResponse apiResponse = await apiHitter.getPutApiResponse(
        ApiEndpoint.UPDATE_PROFILE+"/"+id,
          context,
        data: {
          "name":name,
          "profile_picture":image
         },
      headers: {
          "auth_token":auth_token
      }
    );

    if (apiResponse.status) {
      return LoginModel.fromJson(apiResponse.response.data);
    } else {
      return LoginModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }

}