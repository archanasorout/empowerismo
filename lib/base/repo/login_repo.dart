
import 'package:empowerismo/base/BaseRepository.dart';
import 'package:empowerismo/base/constants/ApiEndpoint.dart';
import 'package:empowerismo/base/model/forgot_password_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/model/logout_model.dart';
import 'package:empowerismo/base/model/reset_password_model.dart';
import 'package:empowerismo/base/model/verify_otp_model.dart';
import 'package:empowerismo/base/network/ApiHitter.dart';
import 'package:flutter/cupertino.dart';
 class LoginRepo extends BaseRepository {

  Future<LoginModel> login(BuildContext context,{String email,String password}) async {
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
      ApiEndpoint.LOGIN,
          context,
      data: {
        "email":email,
        "password":password
      }
    );
    if (apiResponse.status) {


      return LoginModel.fromJson(apiResponse.response.data);
    } else {
      return LoginModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }
  Future<ForgotPasswordModel> forgotPassword(BuildContext context,{String email }) async {
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
      ApiEndpoint.FORGOT_PASSWORD,
          context,
      data: {
        "email":email,
      }
    );
    if (apiResponse.status) {
      return ForgotPasswordModel.fromJson(apiResponse.response.data);
    } else {
      return ForgotPasswordModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }
  Future<VerifyOtpModel> verifyOtp(BuildContext context,{String userId,String otp }) async {
    ApiResponse apiResponse = await apiHitter.getPutApiResponse(
      ApiEndpoint.VERIFY_OTP+userId+"/otp",
          context,
      data: {"otp":otp,});
    if (apiResponse.status) {
      return VerifyOtpModel.fromJson(apiResponse.response.data);
    } else {
      return VerifyOtpModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }

  Future<ResetPasswordModel> resetPasswordApi(BuildContext context,{String new_password, String confirm_password,String auth_token,String user_id}) async {
     ApiResponse apiResponse = await apiHitter.getPutApiResponse(
      ApiEndpoint.VERIFY_OTP+user_id+"/reset-password-mobile",
          context,
      data: {
        "new_password":new_password,
        "confirm_password":confirm_password,
      },headers: {
        "auth_token":auth_token
    }

      );
    if (apiResponse.status) {
      return ResetPasswordModel.fromJson(apiResponse.response.data);
    } else {
      return ResetPasswordModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }

  Future<ResetPasswordModel> changePasswordApi(BuildContext context,{String new_password,
    String confirm_password,String auth_token,String user_id,String old_password}) async {
    debugPrint("auth tokennn  "+auth_token);
    debugPrint("user_id  "+user_id);
     ApiResponse apiResponse = await apiHitter.getPutApiResponse(
      ApiEndpoint.VERIFY_OTP+user_id+"/change-password",
           context,
      data: {
        "new_password":new_password,
        "confirm_password":confirm_password,
        "old_password":old_password,
      },headers: {
        "auth_token":auth_token
    }

      );
    if (apiResponse.status) {
      return ResetPasswordModel.fromJson(apiResponse.response.data);
    } else {
      return ResetPasswordModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }

  Future<ResetPasswordModel> resendOtpApi(BuildContext context,{String user_id}) async {
     ApiResponse apiResponse = await apiHitter.getApiResponse(
      ApiEndpoint.VERIFY_OTP+user_id+"/otp",
         context,
     );
    if (apiResponse.status) {
      return ResetPasswordModel.fromJson(apiResponse.response.data);
    } else {
      return ResetPasswordModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }


  Future<LogoutModel> logoutApi(BuildContext context,{String userid,String auth_token }) async {
    debugPrint("userid"+userid);
    debugPrint("auth_token"+auth_token);
    ApiResponse apiResponse = await apiHitter.getPutApiResponse(
      "/user/"+userid+"/logout",
          context,
      headers:{"auth_token":auth_token}
    );
  //  debugPrint("apiResponse"+apiResponse.toString());

    if (apiResponse.status) {
      return LogoutModel.fromJson(apiResponse.response.data);
    } else {
      return LogoutModel(responseCode: 401,responseMessage: apiResponse.msg);
    }
  }

}
