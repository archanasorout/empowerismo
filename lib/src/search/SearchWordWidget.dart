 import 'package:empowerismo/base/bloc/favourite_bloc.dart';
import 'package:empowerismo/base/bloc/search_word_bloc.dart';
import 'package:empowerismo/base/model/get_favourite_list_model.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
 import 'package:empowerismo/base/model/search_word_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/search/result_of_search_widget.dart';
import 'package:empowerismo/src/dashboard/dictionary_widget.dart';
 import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWordWidget extends StatefulWidget {
  LanguageList languageList;
  LoginModel loginDetail;
  SearchWordWidget(this.languageList, this.loginDetail);

  @override
  _SearchWordWidgetState createState() => _SearchWordWidgetState();
}

class _SearchWordWidgetState extends State<SearchWordWidget> {
  @override
  SearchWordBloc searchWordBloc = new SearchWordBloc();
  SearchWordModel searchWordModel;
String selectWord;
bool isWordSelected=false;
  TextEditingController search_editing_controller = new TextEditingController();
  FavouriteBloc favouriteBloc  = new FavouriteBloc();
  FavouriteModel favouriteModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteBloc.getFavouritelist(context,id:widget.loginDetail.result.sId,auth_token:
    widget.loginDetail.result.jwtToken);
    //favouriteModel= favouriteBloc.favouriteModelbloc.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: EmptyAppBar(colorWhite),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context,"yesss");
          return false;
        },
        child: Container(
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topImages(context,function: (){
                    Navigator.pop(context,"yesss");
                  },sendData: false,
                      center: true,rightFunction: true, text:languageConversion(context,'UI_TEXT_SEARCH_WORD') , right: true, color: purpleColor),
                  commonDivider(
                    color: borderColor,
                    context: context,
                  ),
                  25.verticalSpace(),
                  searchButton(
                      context, search_editing_controller,
                      sourceLanguage:widget.languageList.sourceLanguage ,
                      asset: widget.languageList.targetLanguageFlag, function: (value) {
                    debugPrint("searchWordWidget--value we get in function "+value.toString());
                    setState(() {
                      isWordSelected=false;
                      selectWord="";
                    });

                    if (value.toString().length >= 3) {
                      debugPrint(" three " + value.toString());
                      getSearchWord(
                          target_language:widget.languageList.targetLanguage,
                          search_word: value,
                          auth_token: widget.loginDetail.result.jwtToken
                      );
                    } else {
                      searchWordBloc.searchWordModel.add(
                          SearchWordModel(
                            responseMessage:languageConversion(context,
                                'UI_TEXT_SEARCH_NO_WORD') ,
                            result: [],
                            responseCode: 200,
                          ));
                      debugPrint(" nooo " + value.toString());
                    }
                  },
                      selecteLanguage:() async {
                        final result =  await navigate(
                          context,isAwait: true,
                          screen: DictionaryWidget(true),
                        );
                        if(result!=null) {
                          setState(() {
                            isWordSelected = false;
                            widget.languageList = result;
                          });
                          if (search_editing_controller.text != "" && search_editing_controller.text.length>=3) {
                            getSearchWord(
                                target_language: widget.languageList.targetLanguage,
                                search_word: search_editing_controller.text,
                                auth_token: widget.loginDetail.result.jwtToken
                            );
                          }
                          else{
                            searchWordBloc.searchWordModel.add(
                                SearchWordModel(
                                  responseMessage:languageConversion(context,
                                      'UI_TEXT_SEARCH_NO_WORD'),
                                  result: [],
                                  responseCode: 200,
                                ));
                          }
                          debugPrint("SearchWidget selected language" +

                              widget.languageList.targetLanguage.toString());
                        }
                        //  await navigate(context,isAwait: true, screen: DictionaryWidget());
                      },
                      name:widget.languageList.targetLanguage),
                  _body(context)
                ],
              )),
        ),
      ),
    );

  }

  _body(BuildContext context) {
    return StreamBuilder<SearchWordModel>(
        stream: searchWordBloc.searchWordModel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.responseMessage ==languageConversion(context,
                'UI_RESPONSE_FETCH_WORD')) {
              // if (snapshot.data?.result?.length > 0) {
              if (snapshot.data.result!=null && snapshot.data.result.length > 0 ) {
                return Column(
                  children: [
                    10.verticalSpace(),
                    //recentSearchesItem(context,snapshot.data.result,0),
                    isWordSelected ? ResultOfSearchWidget(
                        languageList: widget.languageList,
                        loginDetail: widget.loginDetail,
                        word: selectWord) : customListt(
                      list: snapshot.data.result,
                      child: (index) {
                        return recentSearchesItem(
                            context, snapshot.data.result, index);
                      },
                    ),
                  ],
                );
              }
              else return search_editing_controller.text.length<=2?Container():
              Center(
                  child: customText(
                      text:languageConversion(context,
                          'UI_TEXT_SEARCH_NO_WORD') ,
                      style: font(
                          fontSize: 16,
                          color: textDark1Color,
                          fontWeight: FontWeight.w600),
                      margin: EdgeInsets.only( top: 20)),
                );
            } else return
                 Center(
                  child:
                  customText(
                      text:snapshot.data.responseMessage,
                      style: font(
                          fontSize: 16,
                          color: textDark1Color,
                          fontWeight: FontWeight.w600),
                      margin: EdgeInsets.only(  top: 20,left: 20,right: 20))
                //  Text(snapshot.data.responseMessage),
                 );
          } else
            return search_editing_controller.text.length > 3
                ?
                     Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(purpleColor),
                      ),
                    )

                : Container();
        });
  }

  Widget recentSearchesItem(
      BuildContext context, List<Resultt> result, int index) {
      return result!=null ?InkWell(
      onTap: () {
        debugPrint("SearchWordWidget:::word"+result[index].word.toString());
        setState(() {
          isWordSelected=true;
          selectWord=result[index].word;
         search_editing_controller.text="";
        });
        FocusScope.of(context).requestFocus(FocusNode());

      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
        margin: EdgeInsets.only(left: 65, bottom: 10, top: 10),
          child: new RichText(
          text:searchMatch(
            result[index].word,
          ),

    ),
        ),
            commonDivider(
                color: border9Color,
                context: context,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                )),
          ],
        ),
      ),
    ):Container();
  }

  getSearchWord({String target_language, String search_word,String auth_token}) async {
    await searchWordBloc.getSearchWord(context,
        target_language: target_language, search_word: search_word,auth_token:auth_token);
   }
  TextStyle darkStyle = font(
    fontSize: 16, color: textDark1Color,
    fontWeight: FontWeight.w600,),
      lightStyle = font(
        fontSize: 16, color: lightColor,
        fontWeight: FontWeight.w400,);

  TextSpan searchMatch(String match) {
    if (search_editing_controller.text == null ||
        search_editing_controller.text.length==0)
      return TextSpan(text: match, style: lightStyle);
    var refinedMatch = match.toLowerCase();
    var refinedSearch = search_editing_controller.text.toLowerCase();
    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: darkStyle,
          text: match.substring(0, refinedSearch.length),
          children: [
            searchMatch(
              match.substring(
                refinedSearch.length,
              ),
            ),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(text: match, style: darkStyle);
      } else {
        return TextSpan(
          style: lightStyle,
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            searchMatch(
              match.substring(
                refinedMatch.indexOf(refinedSearch),
              ),
            ),
          ],
        );



      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      return TextSpan(text: match, style: lightStyle);
    }
    return TextSpan(
      text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
      style: lightStyle,
      children: [
        searchMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
      ],
    );
  }
 }
