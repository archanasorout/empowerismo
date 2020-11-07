import 'package:empowerismo/base/bloc/login_bloc.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/authentication/login_page.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/src/dashboard/home_page.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/UserRepository.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'account/account_data_widget.dart';
import 'account_detail_widget.dart';
import 'subscription/subscription_widget.dart';

class ProfileWidget extends StatefulWidget {
  LoginModel loginDetail;
  HomePageState homePageState;
  ProfileWidget(this.loginDetail, this.homePageState);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  UserRepo userRepo = new UserRepo();
  LoginBloc loginBloc = new LoginBloc();

  Widget build(BuildContext context) {
    // statusBar(colorWhite);

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: EmptyAppBar(colorWhite),
      body: Container(
         child: SingleChildScrollView(
            child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             topImages(context, center: true, text:languageConversion(context,
                 'UI_TITLE_PROFILE'), right: false, left: false),
             commonDivider(
              color: borderColor,
              context: context,
             ),
            profile(context),
            commonDivider(
                color: borderColor,
                context: context,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10)),
            list(context, "assets/images/user.svg",
                languageConversion(context, 'UI_TITLE_ACCOUNT_DETAILS'),
                function: () async {
             await navigate(context, screen:
              AccountDetailWidget(widget.loginDetail));
             widget.homePageState.getAllData();
            }),
            list(context, "assets/images/file.svg",
            languageConversion(context, 'UI_TITLE_SUBCRIPTION'),
                function: () {
              navigate(context, screen: SubscriptionWidget());
              //  AccountDetailsWidget
            }),
            list(context, "assets/images/settings.svg",
                languageConversion(context, 'UI_TITLE_ACCOUNT_DATA'),
                function: () {
              navigate(context, screen: AccountDetailsWidget());
              //  AccountDetailsWidget
            }),
            list(context, "assets/images/logout.svg", languageConversion(context, 'UI_TITLE_LOGOUT'), function: () async {
             // userRepo.clearPreference();
              //navigate(context,isRemove:true, screen: LoginPage());
              logoutApi(context);

            }),
          ],
        )),
      ),
    );
  }

  Widget list(BuildContext context, String asset, String text,
      {Function function}) {
    return InkWell(
      onTap: () {function();},
      child: Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        padding: 10.paddingAll(),
          decoration: new BoxDecoration(
             borderRadius: new BorderRadius.all(
             Radius.circular(6),
        )),
        child: Row(
          children: [
            CustomImageView(
                margin: EdgeInsets.only(left: 5),
                 height: 16,
                width: 15,
                image: asset,
                svg: true,
                color: text6Color,
                fit: BoxFit.fill),
            15.horizontalSpace(),
            customText(
                alignmentGeometry: Alignment.topLeft,
                text: text,
                style: font(
                    fontSize: 16.0,
                    color: text6Color,
                    fontWeight: FontWeight.w400)
                 )
          ],
        ),
      ),
    );
  }

  Widget text(String text) {
    return customText(
        alignmentGeometry: Alignment.topLeft,
        text: text,
        style: font(
            fontSize: 16.0, color: text6Color, fontWeight: FontWeight.w600));
  }

  Widget profile(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: ListTile(
        visualDensity: VisualDensity(
          horizontal: -4,
        ),

        contentPadding: 0.paddingAll(),
        leading: customNetworkCircleImage(
            margin: 1.marginAll(), height: 50,
            width: 50,
            image: widget.loginDetail.result?.profilePicture.isEmpty
                ? ""
                : widget.loginDetail.result?.profilePicture),
        title: text(widget.loginDetail.result?.name != null
            ? widget.loginDetail.result?.name
            : ""),
        subtitle: customText(
            alignmentGeometry: Alignment.topLeft,
            text: widget.loginDetail.result?.email != null
                ? widget.loginDetail.result?.email
                : "",
            style: font(
                fontSize: 14.0,
                color: text7Color,
                fontWeight: FontWeight.w400)),
      ),
    );
  }
  logoutApi(BuildContext context) async {
    if(widget.loginDetail.result.sId !=null && widget.loginDetail.result.jwtToken!=null)
      {
    var bloc= await LoginBloc().logout(context,
        userId:widget.loginDetail.result.sId,
        authToken:widget.loginDetail.result.jwtToken);
    bloc.responseMessage.toast();
    if(bloc.responseMessage==languageConversion(context, 'UI_RESPONSE_LOGOUT'))
      userRepo.clearPreference();
    navigate(context, isRemove:true,screen: LoginPage());
  }
  else
  debugPrint("nulll data");
  }
}
