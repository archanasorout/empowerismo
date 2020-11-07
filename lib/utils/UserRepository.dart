 import 'dart:convert';

import 'package:empowerismo/base/constants/PrefConstant.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {

  Future<bool> clearPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }



  Future<bool> setPrefrenceData({dynamic data, String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (data is bool)
      return prefs.setBool(key, data);
    else if (data is String)
      return prefs.setString(key, data);
    else if (data is int)
      return prefs.setInt(key, data);
    else
      return false;
  }

  Future<dynamic> getPrefrenceData({dynamic defaultValue, String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (defaultValue is bool)
      return prefs.getBool(key);
    else if (defaultValue is String)
      return prefs.getString(key);
    else if (defaultValue is int)
      return prefs.getInt(key);
    else
      return false;
  }
  Future<LoginModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var u = prefs.getString(
      PrefConstant.USER_LOGIN_DETAILS,
    );
    if (u != null) return LoginModel.fromJson(await json.decode(u));
  }
  Future<LanguageList> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var u = prefs.getString(PrefConstant.LANGUAGE_DETAILS,);
    if (u != null) return LanguageList.fromJson(await json.decode(u));
  }



  Future<bool> saveUser(LoginModel userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PrefConstant.USER_LOGIN_DETAILS, json.encode(userData.toJson()));
  }
  Future<bool> saveLanguage(LanguageList languageModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PrefConstant.LANGUAGE_DETAILS, json.encode(languageModel.toJson()));
  }
}
