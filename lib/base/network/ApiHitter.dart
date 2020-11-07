
 import 'package:dio/dio.dart';
import 'package:empowerismo/base/constants/ApiEndpoint.dart';
import 'package:empowerismo/base/model/logout_model.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:empowerismo/src/authentication/login_page.dart';
import 'package:empowerismo/utils/TimeUtils.dart';
import 'package:empowerismo/utils/UserRepository.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
 import 'package:empowerismo/extensions/UtilExtensions.dart';


class ApiHitter {
  static Dio _dio;

  static Dio getDio({String baseurl = ''}) {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
        baseUrl: baseurl.isEmpty ? ApiEndpoint.BASE_URL : baseurl,
        connectTimeout: 30000,
        receiveTimeout: 30000,
      );
      return new Dio(options)
        ..interceptors
            .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
           return options;
        }, onResponse: (Response response) {
           return response; // continue
        }, onError: (DioError e) {
          return e;
        }));
    } else {
      return _dio;
    }
  }


  Future<ApiResponse> getPostApiResponse(
    String endPoint,BuildContext context, {
    Map<String, dynamic> headers,
    Map<String, dynamic> data,
    String baseurl = '',
        
  }) async {
  bool value= await checkInternetConnection();
  if(value)
    try {
      var response = await getDio(
        baseurl: baseurl,
      ).post(endPoint,
          options: Options(
            headers: headers,
            contentType: "application/json",
          ),
          data: data);
      if(response.data['responseCode']==401 &&
          response.data['responseMessage']==DemoLocalizations.of(context).trans('UI_RESPONSE_AUTHENTICATION'))
      {

        logout(context);
      }
      else {
        return ApiResponse(response.data['responseCode'] == 200,
            response: response, msg: response.data["responseMessage"]);
      }
    } catch (error) {
      return exception(error,context);}
    else{
    return ApiResponse(false, msg:DemoLocalizations.of(context).trans('ERROR_INTERNET_CONNECTION'));
  }
  }

 Future<ApiResponse> getPutApiResponse(
    String endPoint,BuildContext context, {
    Map<String, dynamic> headers,
    Map<String, dynamic> data,
    String baseurl = '',
  }) async {
   bool value= await checkInternetConnection();
   if(value)
     try {
       var response = await getDio(
         baseurl: baseurl,
       ).put(endPoint,
           options: Options(
             headers: headers,
             contentType: "application/json",

           ),
           data: data);
       if(response.data['responseCode']==401 &&
           response.data['responseMessage']==DemoLocalizations.of(context).trans('UI_RESPONSE_AUTHENTICATION'))
         {

          logout(context);
         }
       else {
         return ApiResponse(response.data['responseCode'] == 200,
             response: response, msg: response.data["responseMessage"]);
       }
     }  on DioError catch (error) {
       exception(error,context);
     }
   else{
     return ApiResponse(false, msg:DemoLocalizations.of(context).trans('ERROR_INTERNET_CONNECTION') );
   }

  }

  Future<ApiResponse> getApiResponse(
    String endPoint,BuildContext context, {
    Map<String, dynamic> headers,
    Map<String, dynamic> data,
    String baseurl = '',
        String khase,
  }) async {
    bool value= await checkInternetConnection();
if(value)
    try {
  //debugPrint("khasekhase"+khase.toString());
      var response = await getDio(
        baseurl: baseurl,
      ).get(
            endPoint,
            options: Options(
            headers: headers,
            contentType: "application/json",

          ),
          );
      debugPrint("dataaaaa"+response.statusMessage.toString());
      if(response.data['responseCode']==401 &&
          response.data['responseMessage']==DemoLocalizations.of(context).trans('UI_RESPONSE_AUTHENTICATION'))
      {

        logout(context);
      }else {
        return ApiResponse(response.data['responseCode'] == 200,
            response: response, msg: response.data["responseMessage"]);
      }
    } catch (error) {
      exception(error,context);
    }
   else{
    return ApiResponse(false, msg:DemoLocalizations.of(context).trans('ERROR_INTERNET_CONNECTION'));
    }

  }

  deleteApiResponse(
    String endPoint,BuildContext context,{
    Map<String, dynamic> headers,
    Map<String, dynamic> data,
    String baseurl = '',
  }) async {
    bool value= await checkInternetConnection();
    if(value)
    try {
      var response = await getDio(baseurl: baseurl,).delete(
            endPoint,
            options: Options(
            headers: headers,
            contentType: "application/json",
            ),
          );
      if(response.data['responseCode']==401 &&
          response.data['responseMessage']==DemoLocalizations.of(context).trans('UI_RESPONSE_AUTHENTICATION'))
      {

        logout(context);
      }
      else {
        return ApiResponse(response.data['responseCode'] == 200,
            response: response, msg: response.data["responseMessage"]);
      }
    } catch (error) {
      exception(error,context);
    }
    else{
      return ApiResponse(false, msg:DemoLocalizations.of(context).trans('ERROR_INTERNET_CONNECTION') );
    }
  }

  Future<ApiResponse> getFormApiResponse(String endPoint,BuildContext context,
      {FormData data, Map<String, dynamic> headers,Map<String, dynamic> queryParameters}) async {
    try {
      var response = await getDio().post(

          endPoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            contentType:"application/json",

          )
      );
      debugPrint("response.data"+response.data["responseMessage"]);
      return ApiResponse(response.data['responseCode']==200,
          response: response, msg: response.data["responseMessage"]);
    } catch (error) {
      exception(error,context);
      /*try {
        return ApiResponse(false,
            msg:
                "${error?.response?.data['responseMessage'] ?? "Sorry Something went wrong."}");
      } catch (e) {
        return ApiResponse(false, msg: "Sorry Something went wrong.");
      }*/
    }
  }

  exception(error,BuildContext context){
    try {
      return ApiResponse(false, msg: "${error?.response?.data['responseMessage']
          ?? DemoLocalizations.of(context).trans('ERROR_SOMETHING_WRONG')}");
    } catch (e) {
      if ( DioErrorType.DEFAULT == error.type ||
          DioErrorType.RECEIVE_TIMEOUT == error.type ||
          DioErrorType.CONNECT_TIMEOUT == error.type) {
        debugPrint("error msgg"+error.toString());
        if (error.message.contains('SocketException')) {
          return ApiResponse(false, msg:DemoLocalizations.of(context).trans('ERROR_INTERNET_CONNECTION'));}
       } else {return ApiResponse(false, msg: DemoLocalizations.of(context).trans('ERROR_SOMETHING_WRONG'));}
    }
  }

logout(BuildContext context) async {
  UserRepo  userRepo =new UserRepo();
  disposeProgress();
  userRepo.clearPreference();
  DemoLocalizations.of(context).trans('UI_RESPONSE_TOKEN_EXPIRED').toast();
  navigate(context, screen: LoginPage(), isInfinity: true);
 /* UserRepo userRepo = UserRepo();
  var value = await userRepo.getUser();
  if(value!=null)
    {
      logoutApi(context,userid:value.result.sId,
          auth_token:value.result.jwtToken );
    }*/
}
  Future<LogoutModel> logoutApi(BuildContext context,{String userid,String auth_token }) async {
    debugPrint("userid"+userid);
    debugPrint("auth_token"+auth_token);
    var response = await getDio(
      baseurl:"",
    ).put("/user/"+userid+"/logout",
        options: Options(
          headers: {
            "auth_token":auth_token
          }, contentType: "application/json",
        ),
       );
    if(response.data['responseMessage']==DemoLocalizations.of(context).trans("UI_RESPONSE_LOGOUT"))
    {
      navigate(context, screen: LoginPage(), isInfinity: true);
    }
   /* ApiResponse apiResponse = await getPutApiResponse(
        "/user/"+userid+"/logout",
        context,
        headers:{"auth_token":auth_token}
    ).then((value) {

    });*/
    //  debugPrint("apiResponse"+apiResponse.toString());

  }

}

class ApiResponse {
  final bool status;
  final String msg;
  final Response response;

  ApiResponse(this.status, {this.msg = "Success", this.response});
}
