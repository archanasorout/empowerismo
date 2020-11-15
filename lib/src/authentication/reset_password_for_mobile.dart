import 'package:empowerismo/base/model/verify_otp_model.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:empowerismo/base/bloc/login_bloc.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class ResetPassword extends StatefulWidget {
  Result result;
  ResetPassword(this.result);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  LoginBloc loginBloc = new LoginBloc();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  bool isPasswordValid=false;
  bool isNewPass=true;
  bool isConfirmPass=true;
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
        builder: (context) =>
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.verticalSpace(),
                  customText(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    text:DemoLocalizations.of(context).trans('UI_ENTER_NEW_PASSWORD'),
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
                  loginPasswordTextField(
                    context,
                    "assets/images/lock.svg",
                    DemoLocalizations.of(context).trans('UI_HINT_NEW_PASSWORD')
                    ,
                    true,
                    height: 16.72,
                    width: 13.93,
                    password: true,
                    controller: newPassController,
                    isShowPass:true,
                      isPassShowing:isNewPass,
                      function:(){
                        if(isNewPass)
                        {
                          setState(() {isNewPass=false;});
                        }else{
                          setState(() {isNewPass=true;});
                        }
                      },
                      onChanged:(value){
                        debugPrint("valueee"+value);
                        setState(() {
                          isPasswordValid=validateStructure(value);
                        });

                      }
                  ),
                  newPassController.text.length>0 && !isPasswordValid?validationWidget(
                      DemoLocalizations.of(context).trans('UI_PASSWORD_VALIDATION')):Container(),
                  15.verticalSpace(),
                  loginPasswordTextField(
                    context,
                    "assets/images/lock.svg",
                    DemoLocalizations.of(context).trans('UI_HINT_CONFIRM_PASSWORD'),
                    true,
                    height: 16.72,
                    width: 13.93,
                    password: true,
                    controller: confirmPassController,
                    isShowPass:true,
                      isPassShowing:isConfirmPass,
                      function:(){
                        if(isConfirmPass)
                        {
                          setState(() {isConfirmPass=false;});
                        }else{
                          setState(() {isConfirmPass=true;});
                        }

                      },
                      onChanged:(value){
                        debugPrint("dslkhduj"+value);
                        setState(() { });

                      }
                  ),
                  confirmPassController.text.length>0 && confirmPassController.text!=newPassController.text?validationWidget(
                      DemoLocalizations.of(context).trans('UI_TOAST_CONFIRM_NEW_NOT_MATCHED')):Container(),
                  50.verticalSpace(),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 30,),
                    child: CustomButton(
                      context,
                      function: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (newPassController.text.isEmpty) {
                          DemoLocalizations.of(context).trans('UI_TOAST_ENTER_NEW_PASSWORD').toast();
                        }else if (!isPasswordValid) {
                          DemoLocalizations.of(context).trans('UI_TOAST_ENTER_VALID_NEW_PASSWORD') .toast();
                        }
                        else if (confirmPassController.text.isEmpty) {
                          DemoLocalizations.of(context).trans('UI_TOAST_ENTER_CONFIRM_PASSWORD').toast();
                        } else if (confirmPassController.text!=newPassController.text ) {
                          DemoLocalizations.of(context).trans('UI_TOAST_CONFIRM_RESET_NOT_MATCHED').toast();
                        }
                        else {
                          changePasswordApi(
                              newPassController.text,confirmPassController.text,widget.result.jwtToken,widget.result.sId, context);
                        }
                      },
                      width: screenWidth(context),
                      decoration: false,
                      gradient: false,
                      text: DemoLocalizations.of(context).trans('UI_BUTTON_CHANGE_PASS_CONTINUE'),
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
  validationWidget(String validation){
    return customText(
      margin: EdgeInsets.only(left: 20, right: 20),
      textAlign:TextAlign.start,
      text:"*"+validation,
      maxLine: 5,
      style: font(
          fontSize: 16.0,
          color: Colors.red,
          fontWeight: FontWeight.w600),
    );
  }
  Widget loginPasswordTextField(BuildContext context, String asset, String text,
      bool view,
      {double height: 15,
        double width: 15,
        bool password: false,
        TextEditingController controller,
        bool isShowPass: false,
        bool isPassShowing:false,
        Function function,
        Function onChanged,
      }) {
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
        leading:
        InkWell(
          onTap: (){
            function();
          },
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Icon(
                Icons.visibility,
                color: isPassShowing ? text11Color : purpleColor,
              )),
        ),
        functionForEditText:(value){
          onChanged(value);
        },
        controller: controller,
        hintStyle: font(
            fontSize: 16.0, color: text11Color, fontWeight: FontWeight.w400),
        radious: 5.0,
        hint: text,
        isObsure: isPassShowing,
        textField: true,

      ),
    );
  }

  changePasswordApi(String new_password, String confirm_password,
      String auth_token, String user_id, BuildContext context) async {
    {
      launchProgress(context: context);
      var bloc = await LoginBloc().resetPasswordApi(context,new_password: new_password,
          confirm_password: confirm_password,
          auth_token: auth_token,
          user_id: user_id);
      disposeProgress();
      bloc.responseMessage.toast();
      if (bloc.responseCode == 200 &&
          bloc.responseMessage ==DemoLocalizations.of(context).trans('UI_RESPONSE_PASSWORD_RESET')
              ) {
        navigate(context, screen: LoginPage(), isInfinity: true);
      }
    }
  }
}
