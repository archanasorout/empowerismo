import 'package:empowerismo/animations/ShowUp.dart';
import 'package:empowerismo/base/bloc/search_bloc.dart';
import 'package:empowerismo/base/bloc/search_word_bloc.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/model/select_word_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/favourite/favourites_list_widget.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ResultOfSearchWidget extends StatefulWidget {
  LanguageList languageList;
  String word;
  LoginModel loginDetail;
  ResultOfSearchWidget({this.languageList,this.word,this.loginDetail}) ;
  @override
  _ResultOfSearchWidgetState createState() => _ResultOfSearchWidgetState();
}

class _ResultOfSearchWidgetState extends State<ResultOfSearchWidget> {

  SearchBloc searchBloc;
  TextEditingController controller = new TextEditingController();

 /* _ResultOfSearchWidgetState(){
    searchBloc = new SearchBloc();
    //debugPrint("ResultOfSearchWidget:::word"+widget?.languageList.targetLanguage.toString());
  }*/
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBloc = new SearchBloc();
   // FocusScope.of(context).requestFocus(FocusNode());
    searchBloc.getSelectedWord(context,target_language:widget.languageList.targetLanguage,search_word: widget?.word,auth_token:widget.loginDetail.result.jwtToken );
  }
  @override
  Widget build(BuildContext context) {

return Column(
  children: [
    20.verticalSpace(),
     _body(context)
  ],
);
  /*  return Scaffold(
      backgroundColor: colorWhite,
      appBar: EmptyAppBar(colorWhite),
      body: Container(
        // height:screenHeight(context)-20,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topImages(context, center: true, text: "Search", right: false),
            commonDivider(
              color: borderColor,
              context: context,
            ),
            20.verticalSpace(),
            searchButton(context, controller,asset:widget?.languageList.targetLanguageFlag ,name:widget?.languageList.targetLanguage ),
            20.verticalSpace(),
            _body(context)

          ],
        )),
      ),
    );*/
  }

  Widget meaningDefination(BuildContext context, String text1, String text2,
      String text3, Color color, String image,
      {FontStyle fontStyle,
      bool icon: false,
      Color backgroundColor,
      Color borderColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        color: backgroundColor,
        borderRadius: new BorderRadius.all(Radius.circular(5)),
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            5.verticalSpace(),
            customText(
              alignmentGeometry: Alignment.topLeft,

              text: text1,

              style: font(
                  fontSize: 15.0,
                  color: text1Color,
                  fontWeight: FontWeight.w400),
                   ),
            15.verticalSpace(),
            customText(
              textAlign: TextAlign.start,
              alignmentGeometry: Alignment.topLeft,
              text: text2,
              style: font(
                  fontStyle: fontStyle,
                  fontSize: 19.0,
                  color: color,
                  fontWeight: FontWeight.w600),
             ),
            10.verticalSpace(),
            customText(
              textAlign: TextAlign.start,
              maxLine: 6,
              alignmentGeometry: Alignment.topLeft,
              text: text3,
              style: font(
                  fontSize: 14.0,
                  color: text2Color,
                  fontWeight: FontWeight.w400),
                ),
            20.verticalSpace(),
            customText(
              maxLine: 6,
              textAlign: TextAlign.start,
              alignmentGeometry: Alignment.topLeft,
              text: text3,
              style: font(
                  fontSize: 14.0,
                  color: text2Color,
                  fontWeight: FontWeight.w400),
            ),
                  20.verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget recentSearchesItem(
    BuildContext context,
    String text1,
    String text2,
    Color color,
    String image,
      {
        ResultOfSelectWord result,
        FontStyle fontStyle,
    bool icon: false,
       bool isfavSelected:false,
        Function function,
  }) {
    return Container(
       margin: EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: ListTile(
        title:
           customText(
            alignmentGeometry: Alignment.topLeft,
            text: text1,
            style: font(
                fontSize: 14.0,
                color: text1Color,
                fontWeight: FontWeight
                    .w400),
           ),

        subtitle: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: customText(
                  textAlign: TextAlign.start,
                  alignmentGeometry: Alignment.topLeft,
                  text: text2,
                  style: font(
                      fontStyle: fontStyle,
                      fontSize: 23.0,
                      color: color,
                      fontWeight: FontWeight
                          .w600),),
              ),
              Row(
                children: [
                  /*customText(
                    textAlign: TextAlign.start,
                    //alignmentGeometry: Alignment.topLeft,
                    text: "Added in 2 lists",
                    style: font(
                        fontStyle: fontStyle,
                        fontSize: 14.0,
                        color: color,
                        fontWeight: FontWeight
                            .w400),),*/
                  InkWell(
                    onTap: () async {
                      function();
                      },
                    child: Container(
                      padding: 10.paddingAll(),
                      child: CustomImageView(
                           height: 18,
                          width: 18,
                          image: image,
                          svg: true,
                          color:isfavSelected?selectedIconColor:textLight1Color,
                          fit: BoxFit.fill),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        //   trailing: ,
      ),
    );
  }

  _body(BuildContext context) {
    return StreamBuilder<SelectWordModel>(
        stream: searchBloc.selectWordBloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.responseMessage ==languageConversion(context,
                'UI_RESPONSE_FETCH_WORDD')) {
              if (snapshot.data.result != null)
                return Container(
                    color:colorWhite,
                  child: Column(
                    children: [
                      recentSearchesItem(context,snapshot.data.result?.sourceLang, snapshot.data.result?.word, textDark1Color,
                          "assets/images/speaker.svg"),
                      commonDivider(
                        color: borderColor,
                        context: context,
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                      ),
                      recentSearchesItem(context,
                          snapshot.data.result?.targetLang,
                          snapshot.data.result?.translation,
                          purple4Color,
                          snapshot.data.favourited?
                          "assets/images/favourite_fill.svg":
                          "assets/images/favourite_unfill.svg",
                        fontStyle: FontStyle.italic, icon: true,
                        result:snapshot.data.result,
                          isfavSelected:snapshot.data.favourited,
                        function: () async {
                          await navigate(context,
                              isAwait: true,
                              screen: FavoritesListWidget(
                              languageConversion(
                                  context,
                              'UI_TITLE_ADD_TO_FAVORITES'),widget.loginDetail,
                          languageList:widget.languageList,
                          resultOfSelectWord:snapshot.data.result,
                              ));
                          searchBloc.getSelectedWord(context,
                              target_language:
                          widget.languageList.targetLanguage,search_word:
                          widget?.word,auth_token:widget.loginDetail.result.jwtToken );
                        }
                      ),
                      meaningDefination(
                          context,
                          "Bedeutung",
                          snapshot.data.result?.word,
                          "Lorem Ipsum ist einfach Dummy-Text des Drucks und   SatzesIndustrie. Lorem Ipsum war schon immer der"
                              " branchenübliche Dummy- Textseit den 1500er Jahren,",
                          textDark1Color,
                          "",
                          fontStyle: FontStyle.italic,
                          icon: false,
                          borderColor: text3Color,
                          backgroundColor: colorWhite),
                      meaningDefination(
                          context,
                          "значение",
                          snapshot.data.result?.translation,
                          "Lorem Ipsum ist einfach Dummy-Text des Drucks und SatzesIndustrie. Lorem Ipsum war schon immer der branchenübliche Dummy- Textseit den 1500er Jahren,",
                          purple4Color,
                          "",
                          fontStyle: FontStyle.italic,
                          icon: false,
                          borderColor: border1Color,
                          backgroundColor: backgroundColor),
                      10.verticalSpace(),
                      /*customText(
                          alignmentGeometry: Alignment.topLeft,
                          text: "Fotos / снимки",
                          style: font(
                              fontSize: 14.0,
                              color: text1Color,
                              fontWeight: FontWeight.w400),
                          margin: EdgeInsets.only(left: 20, bottom: 3)),
                      commonDivider(
                          color: borderColor,
                          context: context,
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          )),
                      Container(
                        margin: 20.marginAll(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            foodImages(context),
                            foodImages(context),
                            foodImages(context),
                          ],
                        ),
                      ),
                      40.verticalSpace(),*/
                    ],
                  ),
                );
              else
                return  Center(
                  child: customText(
                      text:languageConversion(context,
                          'UI_TEXT_NO_MEANING_HERE'),
                      style: font(
                          fontSize: 16,
                          color: textDark1Color,
                          fontWeight: FontWeight.w600),
                      margin: EdgeInsets.only(  top: 20)),
                );
            } else
              return
                 Center(
                     child:  customText(
                       textAlign:TextAlign.start ,
                         text:  snapshot.data.responseMessage,
                         style: font(
                             fontSize: 16,
                             color: textDark1Color,
                             fontWeight: FontWeight.w600),
                         margin: EdgeInsets.only( left: 20,right: 20))
                   ,
                )
              ;
          } else
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(purpleColor),
              ),
            );
        });
  }

  Widget foodImages(BuildContext context) {
    return CustomImageView(
        //  margin: EdgeInsets.only( left: 10,right: 5),
        width: 100,
        height: 100,
        image: "assets/images/food.png",
        svg: false,
        // color: textColor,
        fit: BoxFit.fill);
  }
}
