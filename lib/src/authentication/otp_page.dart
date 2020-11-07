import 'package:empowerismo/base/bloc/login_bloc.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:empowerismo/src/authentication/reset_password_for_mobile.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  String userId;
  OtpPage(this.userId);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  LoginBloc loginBloc = new LoginBloc();
  TextEditingController otpController = TextEditingController();

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
              //3.verticalSpace(),

           /*   commonDivider(
                height: 1,
                color: border11Color,
                context: context,

              ),*/
             15.verticalSpace(),
              customText(
                margin: EdgeInsets.only(left: 20, right: 20),
                text:DemoLocalizations.of(context).trans('UI_ONE_TIME_PASSWORD') ,
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
                  margin: EdgeInsets.only(left: 20, right: 20)),
              30.verticalSpace(),
              LoginPasswordTextField(
                context,
                " ",
                DemoLocalizations.of(context).trans('UI_ENTER_OTP'),
                false,
                height: 13.94,
                width: 18.3,
                controller: otpController,
                isShowPass: false,
              ),
              Container(
                margin: EdgeInsets.only(left: 5,top: 5 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    InkWell(
                      onTap: (){
                        tryResendOtp(widget.userId,context);
                        //navigate(context, screen: OtpPage());
                        },
                      child: Container(
                        margin: 10.marginRight(),
                        padding: 10.paddingAll(),
                        child:RichText(
                          text: TextSpan(
                            text:DemoLocalizations.of(context).trans('UI_NOT_RECEIVE_OTP'),
                            style: font(
                                fontSize: 13.0,
                                color: text19Color,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(text:DemoLocalizations.of(context).trans('UI_TRY_RESEND'), style:font(
                                  fontSize: 13.0,
                                  color: purple1Color,
                                  fontWeight: FontWeight.w400)
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),

              30.verticalSpace(),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 30,),
                child: CustomButton(
                  context,
                  function: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (otpController.text.isEmpty) {
                      DemoLocalizations.of(context).trans('UI_TOAST_ENTER_OTP').toast();
                    }else if (otpController.text.length<6) {
                      DemoLocalizations.of(context).trans('UI_TOAST_ENTER_SIX_NUMBER_OTP').toast();
                    } else {
                      verifyOtp(widget.userId,otpController.text,context);
                    }
                  },
                  width: screenWidth(context),
                  decoration: false,
                  gradient: false,
                  text:DemoLocalizations.of(context).trans('UI_BUTTON_CONTINUE'),
                  height: 45,
                  radius: 5.0,
                  isSingleColor: true,
                  color: purple1Color,
                  textStyle: font(
                      fontSize: 17.0,
                      color: colorWhite,
                      fontWeight: FontWeight.w600),
                ),),

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
        prefix:Container(margin: 10.marginLeft(),),
        boundryColor: true,
        decorationBorderColor: border3Color,
        isdecorationColor: false,
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

  verifyOtp(String userId,String otp, BuildContext context) async {
    launchProgress(context: context);
    var bloc = await LoginBloc().verifyOtpApi(context,userId: userId,otp: otp);
    disposeProgress();
    bloc.responseMessage.toast();
    if (bloc.responseCode == 200 &&
        bloc.responseMessage ==DemoLocalizations.of(context).trans('UI_RESPONSE_OTP_VERIFIED')
            ) {
      navigate(context, screen: ResetPassword(bloc.result), isAwait:true);
    }
  }

  tryResendOtp(String userId,BuildContext context) async {
    launchProgress(context: context);
    var bloc = await LoginBloc().resendOtp(context,user_id: userId);
    disposeProgress();
    bloc.responseMessage.toast();
   /* if (bloc.responseCode == 200 &&
        bloc.responseMessage ==
            "OTP verified successfully") {
     }*/
  }
}
