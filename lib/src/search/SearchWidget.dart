

import 'package:empowerismo/base/bloc/language_bloc.dart';
import 'package:empowerismo/base/bloc/search_word_bloc.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/model/search_remaining_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/dashboard/dictionary_widget.dart';
import 'package:empowerismo/src/dashboard/home_page.dart';
import 'package:empowerismo/src/dashboard/menu_widget.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SearchWordWidget.dart';
 class SearchWidget extends StatefulWidget {

  LanguageList languageList;
  LoginModel loginDetail;
  SearchRemainingModel searchRemainingModel;
   HomePageState homePageState;
    SearchWidget(this.homePageState,{this.languageList,this.loginDetail,
    this.searchRemainingModel})
    {

  }
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  HomePage homePage=new HomePage(1);
  LanguageBloc languageBloc ;
  LanguageModel languageModel  ;
  SearchWordBloc searchWordBloc  ;
  bool value ;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    languageBloc =new LanguageBloc();
    searchWordBloc = new SearchWordBloc();
    value = false;
    // if(languageModel==null)
    languageBloc.getLanguage(context);
  }
  @override
  Widget build(BuildContext context) {
     return _build(context);
  }
  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(purpleColor),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: screenWidth(context),
                height: 200,
                child: CustomImageView(
                    height: 80,
                    image: "assets/images/background_image.jpg",
                    svg: false,
                    fit: BoxFit.fill),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topImages(context),
                  80.verticalSpace(),
                  searchButton(context),
                  30.verticalSpace(),
                  customText(
                      text:DemoLocalizations.of(context).trans('UI_TEXT_RECENT_SEARCHES')  ,
                      style: font(
                          fontSize: 14,
                          color: textDark1Color,
                          fontWeight: FontWeight.w600),
                      margin: EdgeInsets.only(
                        left: 20,
                      )),
                  10.verticalSpace(),
                  customListt(
                  function: ({index}){},
                          child:(index){
                          return  recentSearchesItem(
                              context, "assets/images/favourite_unfill.svg");
                          }
                          ),
                  80.verticalSpace(),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: searchBackgroudColor,
    );
    //  );
  }

  Widget topImages(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 20,
          width: 180,
          child: AspectRatio(
            aspectRatio: 100,
            child: CustomImageView(
                margin: 15.marginLeft(),
                color: Colors.white,
                image: "assets/images/logo_white.svg",
                svg: true,
                fit: BoxFit.fill),
          ),
        ),
        CustomImageView(
            function: () {
              navigate(context, screen: MenuWidget());
            },
            padding: 20.paddingAll(),
            color: Colors.white,
            image: "assets/images/menu.svg",
            svg: true,
            fit: BoxFit.fill),
      ],
    );
  }

  Widget recentSearchesItem(BuildContext context, String asset) {
    return Container(
       margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      decoration: new BoxDecoration(
           borderRadius: new BorderRadius.all(
        Radius.circular(5.0),
      )),

      child: Card(
        elevation: 3,
        child: ListTile(
            title: customText(
              alignmentGeometry: Alignment.topLeft,
              text: "Kraftfahrzeug",
              style: font(
                  fontSize: 16.0,
                  color: textDark1Color,
                  fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Container(
              child: Row(
                children: [
                  customText(
                    alignmentGeometry: Alignment.topLeft,
                    text: "Моторно превозно средство",
                    style: font(
                        fontSize: 12.0,
                        color: textLight1Color,
                        fontWeight: FontWeight.w400),
                  ),
                  CustomImageView(
                      margin: 10.marginLeft(),
                      height: 15,
                      width: 15,
                      image: "assets/images/speaker.svg",
                      svg: true,
                      color: textLight1Color,
                      fit: BoxFit.fill),
                ],
              ),
            ),
            trailing: InkWell(
              onTap: () {
               value = true;
              },
              child: Container(
                padding: 5.paddingAll(),
                child: CustomImageView(
                    width: 15,
                    height: 15,
                    image: asset,
                    svg: true,
                    color: textColor,
                    fit: BoxFit.fill),
              ),
            )),
      ),
    );
  }

  Widget searchButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Card(
        elevation: 3,
        child: CustomTextFieldWithBackgroundColor(
          function: () async {
            var data=    await navigate(context, isAwait:true,
                screen: SearchWordWidget(widget.languageList,widget.loginDetail));
               debugPrint("datadatadata"+data);
               if(data=="yesss")
                 widget.homePageState.getSearchRemaining(
                     widget.loginDetail.result.jwtToken,
                 );
              widget.homePageState.getLanguageData();
          },
          leading: Container(
            margin: EdgeInsets.only( right: 20,),
            width: 63,
            height: 35,
            padding:7.paddingAll(),
            decoration: new BoxDecoration(
                border: Border.all(color: border10Color),
                color: background2Color,
                borderRadius: new BorderRadius.all(
                  Radius.circular(20),
                )),
            child: Center(
                child: Text(
                  widget.searchRemainingModel.searchRemaining.toString()+DemoLocalizations.of(context).trans('UI_TEXT_COUNT') ,style:font(
              fontSize: 15.0,
              color: purple1Color,
              fontWeight: FontWeight.w600,
            ),
            )),
          ),
          prefix: CustomImageView(
              margin: EdgeInsets.only(left: 20, right: 5),
             width: 15,
              height: 15,
              image: "assets/images/search.png",
              svg: false,
              color: textColor,
              fit: BoxFit.fill,
          ),
          hintStyle: font(
              fontSize: 16.0,
              color: searchTextColor,
              fontWeight: FontWeight.w400,
          ),
          radious: 5.0,

           margin: EdgeInsets.only(top: 18),
          hint:DemoLocalizations.of(context).trans('UI_TEXT_SEARCH_HERE'),
          textField: false,
          columnChild: Column(
            children: [
              commonDivider(
                  color: borderColor,
                  context: context,
                  margin: EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 12)),
            widget.languageList!=null?dropDownForLanguageSelect(context):Container(),

              20.verticalSpace(),
            ],
          ),
        ),
      ),
    );
  }
dropDownForLanguageSelect(BuildContext context)
{
  return InkWell(
    onTap: () async {
      final result =await navigate(context,isAwait: true, screen: DictionaryWidget(false));
     if(result!=null)
      setState((){widget.languageList=result;});
     debugPrint("SearchWidget selected language"+widget.languageList.targetLanguage.toString());
    },
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              countryWidget(false, context,  widget.languageList?.sourceLanguage, null),
                  CustomImageView(
                      color: textLight1Color,
                      height: 10,
                      width: 15,
                      image: "assets/images/right_arrow.svg",
                      svg: true,
                      /*color: purpleColor,*/
                      fit: BoxFit.fill,
                      margin: EdgeInsets.only(right: 20),
                  ),
                ]),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  countryWidget(false, context, widget.languageList?.targetLanguage,
                      widget.languageList?.targetLanguageFlag),
                  CustomImageView(
                      color: textLight1Color,
                      height: 5,
                      width: 8,
                      image: "assets/images/down_arrow.svg",
                      svg: true,
                      fit: BoxFit.fill,
                      margin: EdgeInsets.only(right: 20),
                  )
                ]),
          ),
        ]),
  );

 /* return  StreamBuilder<LanguageModel>(
      stream: widget.languageBloc.languageModel.stream,
      builder: (context, snapshot)
      {
        if (snapshot.hasData)
        {
          if(snapshot.data.responseMessage=="Languages List fetched successfully")
          {
           return InkWell(
              onTap: () {
                navigate(context, screen: DictionaryWidget());
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
 countryWidget(false, context, snapshot.data?.languageList[0]?.sourceLanguage, null
        ),
                            CustomImageView(
                                color: textLight1Color,
                                height: 10,
                                width: 15,
                                image: "assets/images/right_arrow.svg",
                                svg: true,
                                *//*color: purpleColor,*//*
                                fit: BoxFit.fill,
                                margin: EdgeInsets.only(right: 20)),
                          ]),
                    ),
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
    countryWidget(false, context, snapshot.data?.languageList[0]?.targetLanguage,snapshot.data?.languageList[0]?.targetLanguageFlag),
                            CustomImageView(
                                color: textLight1Color,
                                height: 5,
                                width: 8,
                                image: "assets/images/down_arrow.svg",
                                svg: true,
                                fit: BoxFit.fill,
                                margin: EdgeInsets.only(right: 20))
                          ]),
                    ),
                  ]),
            );
          }else
            return Center(
              child: Text(snapshot.data.responseMessage),
            );
        }
        else
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(purpleColor),
            ),
          );
      });*/

}
  Widget countryWidget(bool dropDown, BuildContext context, String text,String asset) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
      ),
      child: Row(
        children: [
      asset!=null?customNetworkCircleImage(
             height: 20,
            width: 20,
            image: asset,
          ):
          CustomCircleImageView(
              image: 'assets/images/german_flag.png',
              file: null,
              height: 20,
              width: 20),
          customText(
              text: text,
              style: font(
                  fontSize: 14.0,
                  color: textDarkColor,
                  fontWeight: FontWeight.w400),
                  margin: EdgeInsets.only(left: 5, right: 10),
          ),
          dropDown
              ? CustomImageView(
                  color: textLight1Color,
                  height: 5,
                  width: 8,
                  image: "assets/images/down_arrow.svg",
                  svg: true,
                  fit: BoxFit.fill,
                  margin: EdgeInsets.only(left: 20))
              : Container(),
        ],
      ),
    );
  }

}
