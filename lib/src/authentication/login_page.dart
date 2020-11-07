import 'package:empowerismo/base/bloc/login_bloc.dart';
import 'package:empowerismo/base/constants/PrefConstant.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/dashboard/home_page.dart';
 import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/UserRepository.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:empowerismo/src/authentication/forgot_password_page.dart';

import 'change_password.dart';
import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRepo userRepo = new UserRepo();
  LoginBloc loginBloc = new LoginBloc();
  //FlutterTts flutterTts = FlutterTts();
 // TtsState ttsState ;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassShowing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                margin: EdgeInsets.only(left: 20, right: 20),
                text:DemoLocalizations.of(context).trans('UI_LOGIN') ,
                style: font(
                    fontSize: 22.0,
                    color: textDark1Color,
                    fontWeight: FontWeight.w600),
              ),
              10.verticalSpace(),
              commonDivider(
                  height: 1,
                  color: border4Color,
                  context: context,
                  margin: EdgeInsets.only(left: 20, right: 20)
              ),
              20.verticalSpace(),
              LoginPasswordTextField(
                context,
                "assets/images/message.svg",
                DemoLocalizations.of(context).trans('UI_EMAIL')  ,
                false,
                height: 13.94,
                width: 18.3,
                controller: emailController,
                isShowPass: false,
              ),
              15.verticalSpace(),
              LoginPasswordTextField(
                context,
                "assets/images/lock.svg",
                DemoLocalizations.of(context).trans('UI_PASSWORD'),
                true,
                height: 16.72,
                width: 13.93,
                password: true,
                controller: passwordController,
                isShowPass: isPassShowing,
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Expanded(child: Container()),
                    InkWell(
                      onTap: (){
                        navigate(context, screen: ForgotPasswordPage());
                        //navigate(context, screen: ChangePasswordPage());

                       },
                      child: Container(
                        padding: 20.paddingAll(),
                        child: customText(
                          text: DemoLocalizations.of(context).trans('UI_FORGOT_PASSSWORD'),
                          style: font(
                              fontSize: 13.0,
                              color: purple1Color,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 30, ),

                child: CustomButton(
                  context,
                  function: () {
               //     _speak();
                    FocusScope.of(context).requestFocus(FocusNode());

                    if (validate(emailController.text, passwordController.text,context))
                      login(
                          emailController.text, passwordController.text, context);
                  },
                  width: screenWidth(context),
                  decoration: false,
                  gradient: false,
                  text: DemoLocalizations.of(context).trans('UI_LOGIN'),
                  height: 45,
                  radius: 5.0,
                  isSingleColor: true,
                  color: purple1Color,
                  textStyle: font(
                      fontSize: 16.0,
                      color: colorWhite,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget LoginPasswordTextField(
      BuildContext context, String asset, String text, bool view,
      {double height: 15,
      double width: 15,
      bool password: false,
      TextEditingController controller,
      bool isShowPass}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),

      color: colorWhite,
      width: screenWidth(context) - 20,
      child: CustomTextFieldWithBackgroundColor(
       /* function: () {
          customDialog(context, widget: ShowFileDialog());
        },*/
        boundryColor: true,
        decorationBorderColor: border3Color,
        isdecorationColor: false,
        prefix: Row(
          children: [
            //  Icon( Icons.remove_red_eye)
            CustomImageView(
                margin: EdgeInsets.only(left: password ? 12 : 10, right: 10),
                width: width,
                height: height,
                image: asset,
                svg: true,
                color: text11Color,
                fit: BoxFit.fill),
            Container(
              margin: 5.marginRight(),
              height: 30,
              color: borderColor,
              width: 1,
            ),
          ],
        ),
        controller: controller,
        hintStyle: font(
            fontSize: 16.0, color: text11Color, fontWeight: FontWeight.w400),
        radious: 5.0,
        hint: text,
        isObsure: isShowPass,
        textField: true,
        leading: view
            ? InkWell(
                onTap: () {
                  debugPrint("click to show pass" + isShowPass.toString());
                  setState(() {
                    if (isPassShowing)
                      isPassShowing = false;
                    else
                      isPassShowing = true;
                  });

                  //  loginBloc.showPasswordBloc.add(isShowPass);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      Icons.visibility,
                      color: isPassShowing ? text11Color : purpleColor,
                    )),
              )
            /*CustomImageView(
          function: (){
                 loginBloc.showPasswordBloc.add(isShowPass);
          },
                margin: EdgeInsets.only(left: 10, right: 10),
                width: 20,
                height: 13,
                image:  "assets/images/view.svg",
                svg: true,
                color:isShowPass?purpleColor:text11Color,
                fit: BoxFit.fill)*/
            : Container(),
      ),
    );
  }

  Future<void> login(email, password, BuildContext context) async {
    launchProgress(context: context);
    var bloc = await LoginBloc().loginApi(context,email: email, password: password);
    disposeProgress();
    bloc.responseMessage.toast();
    if (bloc.responseCode == 200 && bloc.responseMessage=="Login successfully.") {
      await userRepo.setPrefrenceData(data: true, key: PrefConstant.USER_LOGIN);
   var isSave= await userRepo.saveUser(bloc);
      if(isSave)
      navigate(context, screen: HomePage(1), isInfinity: true);
      else
        debugPrint("LoginPage:: data not save in shareprefrence in flutter");
    }
  }

}
