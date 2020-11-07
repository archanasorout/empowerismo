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

class SubscriptionWidget extends StatelessWidget {
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

         body:
           Container(
             child: SingleChildScrollView(
                child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 topImages(context,center: true,text:languageConversion(context, 'UI_TITLE_SUBCRIPTION') ,right: false,left: true,leftAsset:"assets/images/left_arrow.svg" ),

                  commonDivider(
                  color: borderColor,
                  context: context,
                 ),

                profile(context),
                commonDivider(
                    height: 2.0,
                    color: border4Color,
                    context: context,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 20)),
                15.verticalSpace(),

                StreamBuilder(
                    stream: profileBloc.ListOfChanges.stream,
                    builder: (context, snapshot) {
                      return Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          padding: 15.paddingAll(),
                          decoration: new BoxDecoration(
                              color: background1Color,
                              border: Border.all(color: border6Color),
                              borderRadius: new BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Column(children: [
                            subscriptionDetails(context,
                 languageConversion(context, 'UI_TEXT_CURRENT_SUBSCRIPTION'),
                                languageConversion(context,
                                    'UI_TEXT_JHONE_DOE'),
                                languageConversion(context,
                                    'UI_TEXT_EDIT'), function: () {
                              listOfchanges.add("true");
                              profileBloc.ListOfChanges.add(listOfchanges);
                            },
                                edit: snapshot.data == null
                                    ? "false"
                                    : snapshot.data[0]),
                            commonDivider(
                                color: borderColor,
                                context: context,
                                margin: EdgeInsets.only(bottom: 10, top: 15)),
                            paymentDetailsWidget(
                                context,languageConversion(
                                context,
                                "UI_PASSWORD"),languageConversion(
                                context,
                                "UI_TEXT_JHONE_DOE"),
                                languageConversion(context,
                                "UI_TEXT_CHANGE")
                            ),
                          ]));
                    }),
//5.verticalSpace(),
                customText(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                  maxLine: 3,
                  alignmentGeometry: Alignment.centerLeft,
                  textAlign: TextAlign.start,
                  text:languageConversion(
                      context,
                      "UI_TEXT_MEMBERSHIP"),
                  style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: text15Color),
                ),

                30.verticalSpace(),
                Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding: 15.paddingAll(),
                    decoration: new BoxDecoration(
                        color: background1Color,
                        border: Border.all(color: border6Color),
                        borderRadius: new BorderRadius.all(
                          Radius.circular(10),
                        )),

                    child: customListt(
                      child:(index){
                      return  Column(children: [
                        listOfPaymentDetails(
                            context,languageConversion(
                            context,
                            "UI_TEXT_CURRENT_SUBSCRIPTION"),
                            languageConversion(
                                context,
                                "UI_TEXT_JHONE_DOE"),
                            languageConversion(context,
                            "UI_TEXT_EDIT"),
                            function: () {
                          listOfchanges.add("true");
                          profileBloc.ListOfChanges.add(listOfchanges);
                        }, edit: null),
                        10.verticalSpace(),
                        customText(
                          textAlign: TextAlign.start,
                          maxLine: 2,
                          alignmentGeometry: Alignment.centerLeft,
                          text:languageConversion(context,
                              "UI_TEXT_SERVICE_PERIOD") ,
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: text14Color),
                          //margin: EdgeInsets.only(left: 60,bottom: 10, )
                        ),
                        text(languageConversion(context,
                            "UI_TEXT_DATE")),
                        10.verticalSpace(),
                        customText(
                          textAlign: TextAlign.start,
                          maxLine: 2,
                          alignmentGeometry: Alignment.centerLeft,
                          text:languageConversion(context,
                              "UI_TITLE_SUBCRIPTION") ,
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: text14Color),
                          //margin: EdgeInsets.only(left: 60,bottom: 10, )
                        ),
                        downloadAndPremiumWidget(context:context,function:(){
                  //    navigate(context, screen: CreateNewListWidget());

                      },

                          textt:languageConversion(context,
                              "UI_TEXT_PERIUM"),asset:"assets/images/download.svg" ),
                        commonDivider(
                            color: borderColor,
                            context: context,
                            margin: EdgeInsets.only(bottom: 20, top: 20)),

                      ]);
  } )

                ),
                20.verticalSpace(),

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

  Widget text(String text,{Color color:text6Color,double size=14}) {
    return customText(
      textAlign: TextAlign.start,
      maxLine: 2,
      alignmentGeometry: Alignment.centerLeft,
      text: text,
      style: GoogleFonts.lato(
          fontSize: size, fontWeight: FontWeight.w600, color:color ),
      //margin: EdgeInsets.only(left: 60,bottom: 10, )
    );
  }

  Widget paymentDetailsWidget(
      BuildContext context, String text1, String text2, String text3,
      {Function function, String edit: "false"}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

             text(languageConversion(context,
                 "UI_TEXT_PAYMENT_DETAILS")),

15.horizontalSpace(),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  function: () {
                    function();
                  },
                  maxLine: 2,
                  alignmentGeometry: Alignment.centerLeft,
                  textAlign: TextAlign.start,
                  text:languageConversion(context,
                      "UI_TEXT_BILLING_DATE"),
                  style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: text14Color),
                  //margin: EdgeInsets.only(left: 60,bottom: 10, )
                ),
                10.verticalSpace(),
                Row(
                  children: [
                        CustomImageView(
                        function: () {
                           context.pop();
                        },
                        //   margin:EdgeInsets.only(left: 20) ,
                        //color: Colors.white,
                        height: 10,
                        width: 25,
                        image: "assets/images/visa.svg",
                        svg: true,
                        //  color: textLight1Color,
                        fit: BoxFit.fill),
                    5.horizontalSpace(),
                    text("xxxx",size: 12), 5.horizontalSpace(),
                    text("xxxx",size: 12), 5.horizontalSpace(),
                    text("xxxx",size: 12), 5.horizontalSpace(),
                    Wrap(children: [text("6789",size: 12)]),
                      ],
                ),
                10.verticalSpace(),
                customText(
                  function: () {
                    function();
                  },
                  alignmentGeometry: Alignment.centerRight,

                  text:languageConversion(context,
                      "UI_TEXT_CHANGE"),
                  style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: text8Color),
                  //margin: EdgeInsets.only(left: 60,bottom: 10, )
                ),
                5.verticalSpace(),
              ],
            ),
          ),
          // )
        ],
      ),
    );
  }

  Widget listOfPaymentDetails(
      BuildContext context, String text1, String text2, String text3,
      {Function function, String edit: "false"}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: customText(
              function: () {
                function();
              },
              alignmentGeometry: Alignment.centerLeft,

              text: "24/8/20",
              style: GoogleFonts.lato(
                  fontSize: 14, fontWeight: FontWeight.w400, color: text8Color),
              //margin: EdgeInsets.only(left: 60,bottom: 10, )
            ),
          ),
          Expanded(
              child: customText(
            textAlign: TextAlign.start,
            maxLine: 2,
            alignmentGeometry: Alignment.centerRight,
            text: "\$150.00",
            style: GoogleFonts.lato(
                fontSize: 14, fontWeight: FontWeight.w600, color: text6Color),
            //margin: EdgeInsets.only(left: 60,bottom: 10, )
          )),

          /*   Expanded(
                 child: Align(
                   alignment: Alignment.center,
                   child: CustomButton(

                      context,
margin: 1.marginAll(),
//padding: EdgeInsets.all(12.0),
                      width: 85,
                       borderWithBackgroundColor:true,
                      border: true,
                      decoration: true,
                      gradient: false,
                      text: "Premium",
                      height: 35,
                      radius: 20.0,
                      isSingleColor: true,
                      color: border5Color,
                      textStyle: GoogleFonts.lato(

                        //fontStyle: FontStyle.italic,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: text13Color)),
                 ),
               ),*/

          // )
        ],
      ),
    );
  }

  Widget subscriptionDetails(
      BuildContext context, String text1, String text2, String text3,
      {Function function, String edit: "false"}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: text(text1),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomButton(context,
                  margin: 1.marginAll(),
//padding: EdgeInsets.all(12.0),
                  width: 85,
                  borderWithBackgroundColor: true,
                  border: true,
                  decoration: true,
                  gradient: false,
                  text:languageConversion(context,
                      "UI_TEXT_PERIUM"),
                  height: 35,
                  radius: 20.0,
                  isSingleColor: true,
                  color: border5Color,
                  textStyle: GoogleFonts.lato(

                      //fontStyle: FontStyle.italic,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: text13Color)),
            ),
          ),

          Expanded(
            child: customText(
              function: () {
                function();
              },
              alignmentGeometry: Alignment.centerRight,

              text:languageConversion(context,
                  "UI_TEXT_CHANGE"),
              style: GoogleFonts.lato(
                  fontSize: 14, fontWeight: FontWeight.w400, color: text8Color),
              //margin: EdgeInsets.only(left: 60,bottom: 10, )
            ),
          ),
          // )
        ],
      ),
    );
  }

  Widget textFiled(String hint) {
    return Container(
      width: 100,
      //  height: 20,
      child: TextField(
        textAlign: TextAlign.start,
        decoration: new InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: -2.0),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            // contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintStyle: GoogleFonts.lato(
                fontSize: 16, fontWeight: FontWeight.w400, color: text9Color),
            hintText: hint),
        style: GoogleFonts.lato(
            fontSize: 16, fontWeight: FontWeight.w400, color: text9Color),
      ),
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
                5.horizontalSpace(),
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
                                  "UI_TEXT_EDIT"),
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
