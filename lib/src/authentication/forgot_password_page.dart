import 'package:empowerismo/base/bloc/login_bloc.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
 import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  LoginBloc loginBloc = new LoginBloc();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(""),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: textDark1Color,
            size: 20,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonDivider(
                height: 1,
                color: border11Color,
                context: context,
              ),
              20.verticalSpace(),
              customText(
                margin: EdgeInsets.only(left: 20, right: 20),
               // text: "Forgot your password?",
                text: DemoLocalizations.of(context).trans('UI_FORGOT_YOUR_PASSSWORD') ,
                style: font(
                    fontSize: 22.0,
                    color: textDark1Color,
                    fontWeight: FontWeight.w600),
              ),
              10.verticalSpace(),
              customText(
                textAlign: TextAlign.start,
                margin: EdgeInsets.only(left: 20, right: 20),
                text:DemoLocalizations.of(context).trans('UI_SEND_OTP_TO_YOUR_EMAIL'),

                style: font(
                    fontSize: 15.0,
                    color: text18Color,
                    fontWeight: FontWeight.w400),
              ),
              10.verticalSpace(),
              commonDivider(
                  height: 1,
                  color: border4Color,
                  context: context,
                  margin: EdgeInsets.only(left: 20, right: 20)),
              30.verticalSpace(),
              LoginPasswordTextField(
                context,
                "assets/images/message.svg",
                DemoLocalizations.of(context).trans('UI_HINT_ENTER_YOUR_EMAIL') ,
                false,
                height: 13.94,
                width: 18.3,
                controller: emailController,
                isShowPass: false,
              ),
              45.verticalSpace(),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 30,
                ),
                child: CustomButton(
                  context,
                  function: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (emailController.text.isEmpty) {
                      DemoLocalizations.of(context).trans('UI_TOAST_ENTER_EMAIL_ADDRESS').toast();
                    } else {
                      forgotPassApi(emailController.text, context);
                    }
                  },
                  width: screenWidth(context),
                  decoration: false,
                  gradient: false,
                  text:DemoLocalizations.of(context).trans('UI_BUTTON_SEND_OTP'),
                  height: 45,
                  radius: 5.0,
                  isSingleColor: true,
                  color: purple1Color,
                  textStyle: font(
                      fontSize: 17.0,
                      color: colorWhite,
                      fontWeight: FontWeight.w600),
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
        boundryColor: true,
        decorationBorderColor: border3Color,
        isdecorationColor: false,
        prefix: Row(
          children: [
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
      ),
    );
  }

  Future<void> forgotPassApi(email, BuildContext context) async {
    launchProgress(context: context);
    var bloc = await LoginBloc().forgotPasswordApi(context,email: email);
    disposeProgress();
    bloc.responseMessage.toast();
    if (bloc.responseCode == 200 &&
        bloc.responseMessage ==DemoLocalizations.of(context).trans("UI_RESPONSE_CHECK_OTP")) {
      navigate(context, screen: OtpPage(bloc.userId),isAwait:true );
    }
  }
}
