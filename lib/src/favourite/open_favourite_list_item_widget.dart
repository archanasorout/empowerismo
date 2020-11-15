 import 'package:empowerismo/base/model/get_favourite_list_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/src/widget/remove_unfavourite_dialog.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OpenFavouritesListWidget extends StatefulWidget {
  String title;
  List<Words> words;
  String listId;
  LoginModel loginDetail;
  OpenFavouritesListWidget(this.title, this.words,this.listId, this.loginDetail);
  @override
  _OpenFavouritesListWidgetState createState() => _OpenFavouritesListWidgetState();
}

class _OpenFavouritesListWidgetState extends State<OpenFavouritesListWidget> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: EmptyAppBar(colorWhite),
      body:WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child:Container(
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topImages(
                    context,
                    sendData:false,
                    leftAsset: "assets/images/left_arrow.svg",
                    left: true,
                    center: true,
                    text: widget.title,
                    right: true,
                    child: Container(),
                  ),

                  commonDivider(
                    color: borderColor,
                    context: context,
                  ),
                  widget.words?.length ==0
                      ?  Center(
                    child: customText(
                      text:languageConversion(context,
                          'UI_TEXT_SEARCH_NO_WORD')  ,
                      style: font(
                          fontSize: 16,
                          color: textDark1Color,
                          fontWeight: FontWeight.w400),
                      margin: EdgeInsets.only(  top: 20),
                    ),
                  )
                      : Column(
                    children: [
                      20.verticalSpace(),

                      Row(
                        children: [
                          downloadAndPrintWidget(
                              context: context,
                              text:languageConversion(context,
                                  'UI_TEXT_DOWNLOAD'),
                              asset: "assets/images/download.svg"),
                          20.horizontalSpace(),
                        /*  Container(
                            height: 20,
                            width: 1,
                            color: text17Color,
                          ),
                          downloadAndPrintWidget(
                              context: context,
                              text:languageConversion(context,
                                  'UI_TEXT_PRINT') ,
                              asset: "assets/images/printer.svg"),*/
                        ],
                      ),
                      commonDivider(
                        color: borderColor,
                        context: context,
                        margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20,
                        ),
                      ),
                      customListt(
                          list: widget.words,
                          child: (index) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: listOfFavourites(context,widget.words,index)),
                                          InkWell(
                                            onTap: () {
                                              customDialog(context,onDismiss: (data){
                                                if (data != null &&
                                                    data ==
                      languageConversion(context,
                          'UI_RESPONSE_UNFAVOUITE_SUCCESSFULLY'))
                                                {
                                                  setState(() {
                            widget.words.removeAt(index);

                                                  });
                                                }

                                              },
                                                  widget:
                                                  RemoveUnfavouriteDialog(
                                                    widget.words[index].wordId,
                                                    widget.listId,
                                                    widget.loginDetail,
                                                  ));
                                            },
                                            child: Container(
                                              padding: 15.paddingAll(),
                                              child: CustomImageView(
                                                //  margin:EdgeInsets.only(left: 10,right: 15) ,
                                                //color: Colors.white,
                                                  height: 15,
                                                  width: 4, image:
                                   "assets/images/menu _three_dot.svg",
                                                  svg: true,
                                                  color: textLight1Color,
                                                  fit: BoxFit.fill),
                                            ),
                                          )
                                        ]),
                                    widget.words.length==index-1?  commonDivider(
                                      color: borderColor,
                                      context: context,
                                    ):Container(),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),


                  //searchButton(context),
                ],
              )),
        ),
      ),
    );

  }

  Widget downloadAndPrintWidget(
      {BuildContext context, Function function, String text, String asset}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            function();
          },
          child: CustomImageView(
              function: () {
                //    navigate(context, screen: AccountDetailWidget());
                context.pop();
              },
              margin: EdgeInsets.only(
                left: 20,
              ),
              //color: Colors.white,
              height: 20,
              width: 20,
              image: asset,
              svg: true,
              color: text1Color,
              fit: BoxFit.fill),
        ),
        8.horizontalSpace(),
        customText(
          alignmentGeometry: Alignment.topLeft,

          text: text,
          style: GoogleFonts.lato(
              fontSize: 14, fontWeight: FontWeight.w400, color: text1Color),
          //margin: EdgeInsets.only(left: 60,bottom: 10, )
        )
      ],
    );
  }

  Widget text(String text) {
    return customText(
      alignmentGeometry: Alignment.topLeft,

      text: text,
      style: GoogleFonts.lato(
          fontSize: 16, fontWeight: FontWeight.w600, color: textDark1Color),
      //margin: EdgeInsets.only(left: 60,bottom: 10, )
    );
  }

  Widget listOfFavourites(BuildContext context, List<Words> words, index) {
    return ListTile(
      //dense:true ,
      title: text(words[index].word),
      subtitle: customText(
        alignmentGeometry: Alignment.topLeft,
        text: words[index].translation,
        style: GoogleFonts.lato(
            //fontStyle: FontStyle.italic,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textLight1Color),
        //margin: EdgeInsets.only(left: 60,bottom: 10, )
      ),
    );
  }

 }
