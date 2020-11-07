import 'package:empowerismo/base/bloc/favourite_bloc.dart';
 import 'package:empowerismo/base/model/get_favourite_list_model.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
 import 'package:empowerismo/base/model/select_word_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/src/widget/rename_or_delete_dialog.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_list/create_new_list.dart';
import 'open_favourite_list_item_widget.dart';

class FavoritesListWidget extends StatefulWidget {
  String title;
  LoginModel loginDetail;
  LanguageList languageList;
  ResultOfSelectWord resultOfSelectWord;
      FavoritesListWidget(this.title, this.loginDetail,{this.languageList,
        this.resultOfSelectWord,
      });

  @override
  _FavoritesListWidgetState createState() => _FavoritesListWidgetState();
}

class _FavoritesListWidgetState extends State<FavoritesListWidget> {
  FavouriteBloc favouriteBloc  = new FavouriteBloc();
  //FavouriteModel favouriteModel;
  List<FavouriteList> favouriteListtt=new List<FavouriteList>();

  FavouriteModel favouriteModel1;
  String title="Favorite lists";
  bool isClickOnSearch=false;
  TextEditingController SearchController=new TextEditingController();

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    if (widget.loginDetail != null)
      favouriteBloc.getFavouritelist(
        context,
          id: widget.loginDetail.result?.sId,
          auth_token: widget.loginDetail.result?.jwtToken,
      );
  }

  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: colorWhite,
      appBar: EmptyAppBar(colorWhite),
      body:
      WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: Container(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                isClickOnSearch?Container(child:TextField(
                  textAlign: TextAlign.start,
                  autofocus: true,
                  decoration: new InputDecoration(
                    isDense: true,
                    //contentPadding: EdgeInsets.only(bottom: -2.0),
                    border: InputBorder.none,
                     contentPadding: EdgeInsets.only(left: 20,
                       bottom: 11, top: 11, right: 15),
                      hintStyle: GoogleFonts.lato(
                fontSize: 16, fontWeight: FontWeight.w400, color: text9Color),
                      hintText: "Enter Your List Name",
                    prefixIcon:CustomImageView(
                     //margin: EdgeInsets.only(left: 20, right: 5),
                padding: 15.paddingAll(),
                      width: 5,
                      height: 5,
                      image: "assets/images/search.png",
                      svg: false,
                      color: textColor,
                      fit: BoxFit.fill,
                    ),
                  ),
                  onChanged: (value){
                    /*setState((){
                      favouriteModel=null;
                    });*/


                 var filteredList = favouriteModel1.favouriteList.where((element) => element.listName.contains(value));

                 if(filteredList!=null &&filteredList.length>0 ) {
                   debugPrint(
                       "filteredList:::" + filteredList.length.toString());
                   debugPrint(
                       "filteredList:::" + SearchController.text.length.toString());
                  /* favouriteBloc.favouriteModelbloc.sink.add(
                       FavouriteModel()
                         ..favouriteList = filteredList);*/
                    setState(() {
                     favouriteListtt = filteredList;
                    });

                   debugPrint(
                       "datata :::" + favouriteListtt.length.toString());
                 }
                  }
                       // refreshList();


                  ,
                  controller: SearchController,
                  style: GoogleFonts.lato(
                      fontSize: 16, fontWeight: FontWeight.w400, color: text9Color),
                ),):
                topImages(context, center: true,
                    text: widget.title,
                    right: true,
                    child: widget.title ==languageConversion(
                        context, 'UI_TITLE_FAVORITE_LIST')?
                    Container() : null,
                      functionOfSearch:(){
                        refreshList();
                        setState((){
                          isClickOnSearch=true;
                          });


                      },
                  ),
                  commonDivider(
                    color: borderColor,
                    context: context,
                  ),
                  InkWell(
                    onTap: () async {
                      await navigate(
                        context,
                        isAwait: true,
                        screen: CreateNewListWidget(
                          widget.loginDetail,languageConversion(context,
                            'UI_TEXT_CREATE_NEW_LIST'),
                          sId: "",

                          color: "",
                          name: "",

                        ),
                      );
                      refreshList();

                    },
                    child
                        : createNewList(
                      context: context,
                      child: text(languageConversion(context,
                          'UI_TEXT_CREATE_A_NEW_LIST')),
                    ),
                  ),
                if(SearchController.text.length>=1)


                  favouriteListtt?.length==0 ?Center(
    child: CircularProgressIndicator(
        valueColor:
        new AlwaysStoppedAnimation<Color>(purpleColor),
    ),
    ):  customListt (
      list: favouriteListtt,
      child: (index) {
        debugPrint("in filter list");
        return  favList(index,favouriteListtt);},
    ) else       StreamBuilder<FavouriteModel>(
                      stream: favouriteBloc.favouriteModelbloc.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (
                          snapshot.data.responseMessage ==
                              languageConversion(context,
                                  'UI_RESPONSE_FAV_LIST_FETCHED')&&
                              snapshot.data.favouriteList.length > 0) {
                            debugPrint("fav data"+snapshot.data.favouriteList.
                            length.toString());
                            favouriteModel1=snapshot.data;
                         /*   if (favouriteModel == null) {
                              favouriteModel = snapshot.data;
                             // if(favouriteModel1==null)
                              favouriteModel1=snapshot.data;
                              debugPrint("favouriteModel"+
                                  favouriteModel.favouriteList.length.toString());
                              return customListt (
                                list: favouriteModel.favouriteList,
                                child: (index) {
                                  return  favList(index);
                                },
                              );
                            } else {*/
                              debugPrint("yessssss");
                              return customListt (
                                list: snapshot.data.favouriteList,
                                child: (index) {
                                  return  favList(index,snapshot.data.favouriteList);
                                },
                              );
                          //  }
                          } else
                            return Center(
                              child: customText(
                                  text: snapshot.data.responseMessage==
                                      languageConversion(context,
                                          'UI_RESPONSE_FAV_LIST_FETCHED')
                                 ?languageConversion(context,
                                      'UI_RESPONSE_NO_LIST_CREATED_YET')
                                      :snapshot.data.responseMessage,
                                  style: font(
                                      fontSize: 16,
                                      color: textDark1Color,
                                      fontWeight: FontWeight.w600),
                                  margin: EdgeInsets.only(top: 20)),
                            );
                        } else
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                              new AlwaysStoppedAnimation<Color>(purpleColor),
                            ),
                          );
                      }),
                ],
              )),
        ),
      ),
    );
  }

  Widget text(String text) {
      return customText(
      alignmentGeometry: Alignment.topLeft,
      text: text,
      style: GoogleFonts.lato(
      fontSize: 17, fontWeight: FontWeight.w600, color: textDark1Color),
        //margin: EdgeInsets.only(left: 60,bottom: 10, )
      );
  }

  colorValue(String labelColor) {
    return labelColor.toColor();
  }

  Widget favList(int index, List<FavouriteList> favouriteList) {
      return InkWell(
        onTap: () async {
          if (  favouriteList[index].wordCount > 0) {
            await navigate(
              context, isAwait: true, screen:
            OpenFavouritesListWidget(
              favouriteList[index].listName,
              favouriteList[index].words,
               favouriteList[index].sId,
              widget.loginDetail,),);
            refreshList();
          }
          else {
            languageConversion(context,
                'UI_TEXT_SEARCH_NO_WORD').toast(color: purpleColor);
          }
        },
        child:
        Container(
          margin: EdgeInsets.only(
            left: widget.title ==languageConversion(context,
                'UI_TITLE_FAVORITE_LIST')  ? 20 : 5,
            right: widget.title == languageConversion(context,
                'UI_TITLE_FAVORITE_LIST') ? 20 : 5,
          ),
          child:
          Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: listOfFavourites(
                          context, favouriteList, index,
                        )),
                    Expanded(child:
                    Row(
                      children: [
                        Expanded(child:
                        Align(alignment: Alignment.centerRight,
                          child: Container(
                            margin: 20.marginRight(), height: 12, width: 12,
                            decoration: BoxDecoration(
                              color: favouriteList[index]
                                  ?.labelColor != "#ff0"
                                  ? colorValue(
                                favouriteList[index]?.labelColor,
                              ) : Colors.blue,
                              borderRadius: new BorderRadius.all(Radius.circular(10),),
                            ),
                          ),
                        ),
                        ),
                        widget.title == languageConversion(context,
                            'UI_TITLE_FAVORITE_LIST')
                            ? editFavList(index, favouriteList )
                            : addButton(
                          resultOfSelectWord: widget.resultOfSelectWord,
                          list_id: favouriteList[index].sId,
                          index: index,
                            favouriteList: favouriteList
                        )
                      ],
                    ),
                    ),
                  ]),
              favouriteList.length - 1
                  == index ? 20.verticalSpace() : commonDivider(
                color: borderColor, context: context,
                margin: EdgeInsets.only(left: 15, right: 15,),
              ),
              favouriteList.length - 1
                == index?Container(
              margin: 50.marginHorizontal(),
            ):Container(),
              //100.verticalSpace()
            ],
          ),
        ),
      );
    }

  Widget editFavList(int index,List<FavouriteList> favouriteList){
  return InkWell(
  onTap: ()  {
  customDialog(
  context, onDismiss: (data) async {
  if (data != null && data ==languageConversion(context,
      'UI_RESPONSE_DELETE')  )
  deleteDialog(context,index, favouriteList);
  else if(data != null && data ==languageConversion(context,
      'UI_RESPONSE_RENAME') ) {
  var renameData=  await navigate(
  context, isAwait: true, screen:
  CreateNewListWidget(
  widget.loginDetail,
    languageConversion(context,
        'UI_TITLE_RENAME_LIST'),
  sId: favouriteList[index].sId,
    name:favouriteList[index].listName,
      color:favouriteList[index].labelColor,
    indexx: 2,
      ));
  if (renameData != null && renameData==
      languageConversion(context,
          'UI_RESPONSE_FAV_LIST_UPDATED')) {
  refreshList();
  }}},
  widget: ShowFileDialog(
  widget.loginDetail, favouriteList[index],
  ),
  );
  },
    child: Container(
      padding: 15.paddingAll(),
      child: CustomImageView(
          height: 15, width: 4, image: "assets/images/menu _three_dot.svg",
          svg: true, color: textLight1Color, fit: BoxFit.fill,
      ),
    ),
  );
}
  Widget listOfFavourites
  (BuildContext context, List<FavouriteList> favouriteList, index)
  {
  return ListTile(
  title: text(favouriteList[index].listName),
  subtitle: customText(
  alignmentGeometry: Alignment.topLeft,
  text: favouriteList[index].wordCount.toString() +languageConversion(context,
      'UI_TEXT_WORDS'),
  style: GoogleFonts.lato(
  fontStyle: FontStyle.italic, fontSize: 13, fontWeight: FontWeight.w400,
  color: text4Color),),);
  }

  Widget addButton({ResultOfSelectWord resultOfSelectWord,String list_id,int index,List<FavouriteList> favouriteList})
  {
  return InkWell(
  onTap: (){
  if(resultOfSelectWord!=null)
  addedInFavList(resultOfSelectWord:resultOfSelectWord,list_id: list_id);
  },
  child: Container(
  child:CustomButton(context, width: 80, margin: 15.paddingRight(),
  borderWithBackgroundColor:true, decoration:
  addedOrNot(index,resultOfSelectWord.word,  favouriteList)?false:true,
  gradient: false, text: addedOrNot(index,resultOfSelectWord.word,  favouriteList)?languageConversion(context,
          'UI_TEXT_ADDED'):languageConversion(context,
          'UI_TEXT_ADD'),
  height: 30,
  radius: 20.0, isSingleColor: true,
  color: purple1Color, textStyle: GoogleFonts.lato(
  fontSize: 14, fontWeight: FontWeight.w600,
  color:addedOrNot(index,resultOfSelectWord.word,favouriteList)?colorWhite:purple1Color,
  )),),);
  }

    addedOrNot(int index,String word,List<FavouriteList> favouriteList){
    return favouriteList[index].words.any((e) =>
    e.word ==word)?true:false;
    }


    addedInFavList({ResultOfSelectWord resultOfSelectWord,String list_id})
    async {
    launchProgress(context: context);
    var bloc = await favouriteBloc.addToFavList(
      context,
    resultOfSelectWord:resultOfSelectWord,
    auth_token:widget.loginDetail.result.jwtToken,list_id: list_id,
    );
    disposeProgress();
    bloc.responseMessage.toast();
    refreshList();
  }

    refreshList(){
    debugPrint("tttttttttttt");
   // favouriteModel=null;
    favouriteBloc.getFavouritelist(
        context,
    id: widget.loginDetail.result.sId,
    auth_token: widget.loginDetail.result.jwtToken);
    }



  deleteDialog(BuildContext context,int index,List<FavouriteList> favouriteList) {
  showDialog(
  context: context,
  builder: (BuildContext context) => CupertinoAlertDialog(
  content:Text(languageConversion(context,
      'UI_TEXT_DELETE'),style:GoogleFonts.lato(
  fontSize: 17, fontWeight: FontWeight.w400, color: purpleColor) ,) ,
  actions: <Widget>[
  CupertinoDialogAction(
  child: Text(languageConversion(context,
      'UI_TEXT_CANCEL'),style:GoogleFonts.lato(
  fontSize: 17, fontWeight: FontWeight.w400, color: textDark1Color) ,),
  isDefaultAction: true,
  onPressed: () {
   Navigator.pop(context, languageConversion(context,
       'UI_TEXT_CANCEL'));
  }),
  CupertinoDialogAction(
  child: Text(languageConversion(context,
      'UI_TEXT_OK'),style:GoogleFonts.lato(
  fontSize: 17, fontWeight: FontWeight.w400, color: textDark1Color) ,),
  isDefaultAction: true,
  onPressed: () {
  if (
  favouriteList[index].sId != null &&
  widget.loginDetail.result.jwtToken != null
  )
  deleteFromFav(context: context, id: favouriteList[index].sId,
  auth_token: widget.loginDetail.result.jwtToken,);
  }),],), barrierDismissible: true,);}



  deleteFromFav({String id, String auth_token, BuildContext context}) async {
  Navigator.pop(context,);
  launchProgress(context: context);
  var bloc = await favouriteBloc.deleteFavList(context,id: id, auth_token: auth_token);
  disposeProgress();
  bloc.responseMessage.toast();
  if (bloc != null)
  refreshList();
  }
}
