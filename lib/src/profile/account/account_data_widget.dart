import 'dart:io';
import 'package:empowerismo/base/bloc/profile_bloc.dart';
import 'package:empowerismo/base/bloc/util_bloc.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AccountDetailsWidget extends StatelessWidget {
  bool edit = false;
  String image;
  var utilBloc = UtilBloc();
  var profileBloc = ProfileBloc();
  List<String> listOfchanges = List<String>();

  Widget build(BuildContext context) {
    //statusBar(colorWhite);

    return
       Scaffold(
        backgroundColor: colorWhite,
        appBar: EmptyAppBar(colorWhite),
        body: Container(
          // height:screenHeight(context)-20,
          child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //40.verticalSpace(),
                  topImages(context,center: true,text:languageConversion(context, 'UI_TITLE_ACCOUNT_DATA'),right: false,left: true,leftAsset:"assets/images/left_arrow.svg" ),

                 // topImages(context, "Account Data"),
                  //10.verticalSpace(),

                  commonDivider(
                    color: borderColor,
                    context: context,
                    //  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20)
                  ),

                  profile(context),
                  commonDivider(
                      height: 2.0,
                      color: border4Color,
                      context: context,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 20)),
                  15.verticalSpace(),


                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20 ),
                      child: text(languageConversion(context,
                          'UI_TEXT_FOR_REQUST_DELETION'),size: 14,color: text16Color,maxLine: 15,fontWeight: FontWeight.w400)),
                  30.verticalSpace(),
                  CustomButton(
                      context,
                      width: screenWidth(context),
                      decoration: false,
                      gradient: false,
                      text:languageConversion(context,
                          'UI_TEXT_REQUEST_DELETION_ACCOUNT'),
                      height: 45,
                      radius: 25.0,
                      isSingleColor: true,
                      color: border7Color,
                      margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                      textStyle: GoogleFonts.lato(

                        //fontStyle: FontStyle.italic,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorWhite)) ,

                ],
              )),
        ),
      );

  }
  Widget downloadAndPremiumWidget({BuildContext context,Function function,String textt,String asset}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        //   5.horizontalSpace(),
        text(textt),
        /*  customText(

          alignmentGeometry: Alignment.topLeft,

          text: text ,
          style: GoogleFonts.lato(
              fontSize: 14, fontWeight: FontWeight.w400, color: text6Color),
          //margin: EdgeInsets.only(left: 60,bottom: 10, )
        ),*/
        InkWell(
          onTap: (){
            function();
          },
          child: CustomImageView(
              function: (){
                //    navigate(context, screen: AccountDetailWidget());
                context.pop();            },
              margin:EdgeInsets.only(left: 20,) ,
              //color: Colors.white,
              height: 20,
              width: 20,
              image: asset,
              svg: true,
              color: text1Color,
              fit: BoxFit.fill),



        ),

      ],
    );
  }

  Widget text(String text,{Color color:text6Color,double size=14,int maxLine:2,FontWeight fontWeight: FontWeight.w600}) {
    return customText(
      textAlign: TextAlign.start,
      maxLine: maxLine,
      alignmentGeometry: Alignment.centerLeft,
      text: text,
      style: GoogleFonts.lato(
          fontSize: size, fontWeight: fontWeight, color:color ),
      //margin: EdgeInsets.only(left: 60,bottom: 10, )
    );
  }







  Widget profile(BuildContext context) {
    return StreamBuilder<String>(
        stream: utilBloc.stringBloc.stream,
        builder: (context, snapshot) {

          return Container(
            margin: EdgeInsets.only(top: 10, left: 12, right: 20, bottom: 10),
            child: Row(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    CustomCircleImageView(
                        margin:EdgeInsets.all(8),
                        function: () {
                          pickImage();
                        },
                        image: 'assets/images/profile.png',
                        file: image == null ? null : File(image),
                        height: 70,
                        width: 70),
                    Positioned(
                      left:32,
                      top: 65,
                      child: Container(
                        decoration: new BoxDecoration(
                            color:purple5Color ,
                            border: Border.all(color: colorWhite, ),
                            borderRadius: new BorderRadius.all(
                              Radius.circular(20),
                            )) ,
                        height: 23,
                        width: 23,
                        //padding: const EdgeInsets.all(15),
                        child: Icon(Icons.add,color: colorWhite,size: 20,),
                      ),
                    ),
                  ],
                ),
                10.horizontalSpace(),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text("Hi, John Doe"),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            alignmentGeometry: Alignment.topLeft,
                            text: "john.doe@mail.com",
                            style: GoogleFonts.lato(
                              //fontStyle: FontStyle.italic,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: text7Color),
                            //margin: EdgeInsets.only(left: 60,bottom: 10, )
                          ),
                          Container(
                            width: screenWidth(context) - 250,
                            child: customText(
                              alignmentGeometry: Alignment.topRight,
                              text:languageConversion(context,
                                  "UI_TEXT_EDIT")
                              ,
                              style: GoogleFonts.lato(
                                //fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: text8Color),
                              //margin: EdgeInsets.only(left: 60,bottom: 10, )
                            ),
                          ),
                        ],
                      ),
                    ]),
              ],
            ),
          );
        });
  }

  Future<void> pickImage() async {
    var d = await ImagePicker().getImage(source: ImageSource.gallery);
    image = d.path;
    utilBloc.string(value: d.path);
  }
}
