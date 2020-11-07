 import 'package:empowerismo/base/model/forgot_password_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/model/logout_model.dart';
import 'package:empowerismo/base/model/reset_password_model.dart';
import 'package:empowerismo/base/model/verify_otp_model.dart';
import 'package:empowerismo/base/repo/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';



  class LoginBloc {
  var showPasswordBloc = BehaviorSubject<bool>();
   var repo = LoginRepo();

  Future<LoginModel> loginApi(BuildContext context,{String email, String password}) async {
    return await repo.login(context,email: email,password: password);
  }

  Future<ForgotPasswordModel> forgotPasswordApi(BuildContext context,{String email}) async {
    return await repo.forgotPassword(context,email: email);
  }
  Future<VerifyOtpModel> verifyOtpApi(BuildContext context,{String userId,String otp}) async {
    return await repo.verifyOtp(context,userId: userId,otp:otp );
  }

  Future<ResetPasswordModel> resetPasswordApi(BuildContext context,{String new_password,
    String confirm_password,String auth_token,String user_id}) async {
    return await repo.resetPasswordApi(context,new_password: new_password,confirm_password:confirm_password,auth_token:auth_token,user_id:user_id );
  }

  Future<ResetPasswordModel> changePasswordApi(BuildContext context,{String new_password,
    String confirm_password,String old_password,String auth_token,String user_id}) async {
    return await repo.changePasswordApi(context,new_password: new_password,confirm_password:confirm_password,auth_token:auth_token,user_id:user_id,old_password: old_password );
  }



  //{{BaseUrl}}/user/5f6d8b5eec15aa05305049a5/change-password
  Future<ResetPasswordModel> resendOtp(BuildContext context,{String user_id}) async {
    return await repo.resendOtpApi(context,user_id:user_id );
  }


  Future<LogoutModel> logout(BuildContext context,{String userId,String authToken}) async {
    return await repo.logoutApi(context,userid: userId,auth_token: authToken);
  }

  get stream => showPasswordBloc.stream;

  get sink => showPasswordBloc.sink;
  @override
  void dispose() {

    showPasswordBloc.close();

  }
}
