 import 'package:empowerismo/base/bloc/dash_board_bloc.dart';
import 'package:empowerismo/base/bloc/language_bloc.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/model/search_remaining_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:empowerismo/navigation/curved_navigation.dart';
 import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/favourite/favourites_list_widget.dart';
import 'package:empowerismo/src/profile/profile_widget.dart';
import 'package:empowerismo/src/search/SearchWidget.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/UserRepository.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  int index_value;

  HomePage(this.index_value);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DashBoardBloc dashBoardBloc = new DashBoardBloc();
  Function function;
  LoginModel loginDetail;
  SearchRemainingModel searchRemainingModel;
  LanguageBloc languageBloc = new LanguageBloc();
  LanguageModel languageModel;
  GlobalKey<HomePageState> globalKey = GlobalKey();

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
/*    loginDetails().then((value) {
      getSearchRemaining(value.result.jwtToken);
      setState(() {
        loginDetail = value;
      });
    });
    getLanguageData();*/


    }

  @override
/*  Widget build(BuildContext context) {
  return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: Container(color: Colors.blueAccent),
    );
  }*/
  Widget build(BuildContext context) {
    if (loginDetail == null || languageModel == null || searchRemainingModel == null) {
      return Scaffold(body: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(purpleColor),
            ),
          ),);
    } else if (languageModel?.languageList == null) {
      return Scaffold(body:Container(
          margin: 10.marginAll(),
          child: Center(child: Text(languageModel.responseMessage))));
    } else dashBoardBloc.bloc.add(widget.index_value);
    return StreamBuilder<dynamic>(
          stream: dashBoardBloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              resizeToAvoidBottomInset:false,
             // resizeToAvoidBottomPadding:true,
               /* bottomNavigationBar: CurvedNavigationBar(
              height: 50,
              childd: Center(
                child: customText(
                    text: "Search",
                    style: font(
                        fontSize: 14,
                        color:snapshot.data == null?purple2Color
                            :snapshot.data!=1? UnselectedIconColor:purple2Color,
                        fontWeight: FontWeight.w400),

                    margin: EdgeInsets.only(
                      top: 30,
                    )),
              ),
              backgroundColor: snapshot.data == null
                  ? searchBackgroudColor
                  : snapshot.data == 0
                  ? colorWhite
                  : snapshot.data == 1
                  ? searchBackgroudColor
                  : colorWhite,
              items: <Widget>[
                iconsWithText(
                  "Favorites",
                  snapshot.data == null
                      ? UnselectedIconColor
                      : snapshot.data == 0
                      ? purple6Color
                      : UnselectedIconColor,
                  23,
                  null,
                  image: true,
                  child: CustomImageView(
                      height: 20,
                      width: 20,
                      image: snapshot.data == 0
                          ? "assets/images/favourite_fill.svg"
                          : "assets/images/favourite_unfill.svg",
                      svg: true,
                      color: snapshot.data == null
                          ? UnselectedIconColor
                          : snapshot.data == 0
                          ? purple6Color
                          : UnselectedIconColor,
                      fit: BoxFit.fill),
                ),
                CustomImageView(
                    width: 15,
                    height: 15,
                    image: "assets/images/search.svg",
                    svg: true,
                    color: colorWhite,
                    fit: BoxFit.fill),
                iconsWithText(
                    "Profile",
                    snapshot.data == null
                        ? UnselectedIconColor
                        : snapshot.data == 2
                        ? selectedIconColor
                        : UnselectedIconColor,
                    20,
                    null,
                    child: customNetworkCircleImage(
                      height: 25,
                      width: 25,
                      image: loginDetail?.result?.profilePicture == null
                          ? ""
                          : loginDetail.result.profilePicture,
                    ),
                    image: true),
              ],
              index: widget.index_value,
              onTap: (index) {
                debugPrint("hyhvghc"+index.toString());
                if(index==1)
                {
                  getSearchRemaining(loginDetail.result.jwtToken);

                }
                dashBoardBloc.bloc.add(index);
              },
            ),*/
                body:WillPopScope(
                  onWillPop: () async {
                    getAllData();
                  /*  loginDetails().then((value) {
                      getSearchRemaining(value.result.jwtToken);
                      setState(() {
                        loginDetail = value;
                      });
                    });
                    getLanguageData();*/
                    // Navigator.pop(context, false);
                    return false;
                  },
                  child: Stack(
                    children: [
                    snapshot.data == null ?Container(
                      color: searchBackgroudColor,
                    )
                        :snapshot.data==0?FavoritesListWidget(
                        DemoLocalizations.of(context)
                            .trans('UI_TITLE_FAVORITE_LIST'),
                        loginDetail)
                        :snapshot.data == 1 ? SearchWidget(
                      this,
                      languageList: languageModel.languageList != null
                          ? languageModel.languageList[0] : null, loginDetail:loginDetail,
                      searchRemainingModel:searchRemainingModel,)
                        : ProfileWidget(loginDetail,this),
                    Align(
                      alignment:Alignment.bottomCenter,
                      child: CurvedNavigationBar(
                        height: 50,
                        childd: Center(
                          child: customText(
                              text:DemoLocalizations.of(context).
                              trans('UI_BOTTOM_NAVIGATION_SEARCH'),
                              style: font(
                                  fontSize: 14,
                                  color:snapshot.data == null?purple2Color
                                      :snapshot.data!=1? UnselectedIconColor:purple2Color,
                                  fontWeight: FontWeight.w400),

                              margin: EdgeInsets.only(
                                top: 30,
                              )),
                        ),
                        backgroundColor: snapshot.data == null
                            ? searchBackgroudColor
                            : snapshot.data == 0
                            ? colorWhite
                            : snapshot.data == 1
                            ? searchBackgroudColor
                            : colorWhite,
                        items: <Widget>[
                          iconsWithText(
                            DemoLocalizations.of(context).trans('UI_BOTTOM_NAVIGATION_TEXT_FAV') ,
                            snapshot.data == null
                                ? UnselectedIconColor
                                : snapshot.data == 0
                                ? purple6Color
                                : UnselectedIconColor,
                            23,
                            null,
                            image: true,
                            child: CustomImageView(
                                height: 20,
                                width: 20,
                                image: snapshot.data == 0
                                    ? "assets/images/favourite_fill.svg"
                                    : "assets/images/favourite_unfill.svg",
                                svg: true,
                                color: snapshot.data == null
                                    ? UnselectedIconColor
                                    : snapshot.data == 0
                                    ? purple6Color
                                    : UnselectedIconColor,
                                fit: BoxFit.fill),
                          ),
                          CustomImageView(
                              width: 15,
                              height: 15,
                              image: "assets/images/search.png",
                              svg: false,
                              color: colorWhite,
                              fit: BoxFit.fill),
                          iconsWithText(
                              DemoLocalizations.of(context).
                              trans('UI_BOTTOM_NAVIGATION_TEXT_PROFILE') ,
                              snapshot.data == null
                                  ? UnselectedIconColor
                                  : snapshot.data == 2
                                  ? selectedIconColor
                                  : UnselectedIconColor,
                              20,
                              null,
                              child: customNetworkCircleImage(
                                height: 25,
                                width: 25,
                                image: loginDetail?.result?.profilePicture == null
                                    ? ""
                                    : loginDetail.result.profilePicture,
                              ),
                              image: true),
                        ],
                        index: widget.index_value,
                        onTap: (index) {
                          debugPrint("hyhvghc"+index.toString());
                          if(index==1)
                          {
                            getSearchRemaining(loginDetail.result.jwtToken);

                          }
                          dashBoardBloc.bloc.add(index);
                        },
                      ),
                    ),
                  ],),
                /*  snapshot.data == null ?Container(color: searchBackgroudColor,)
                      :snapshot.data==0?FavoritesListWidget("Favorite lists",loginDetail)
                      :snapshot.data == 1 ? SearchWidget(this,
                    languageList: languageModel.languageList != null
                        ? languageModel.languageList[0] : null, loginDetail:loginDetail,
                    searchRemainingModel:searchRemainingModel,)
                      : ProfileWidget(loginDetail),*/
                ),

            );
          });
  }

  iconsWithText(String text, Color color, double sizeOfIcon, IconData iconData,
      {bool image, Widget child}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
           child: Column(
            mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image ? child : Icon(iconData, color: color, size: sizeOfIcon),
              3.verticalSpace(),
              customText(
                text: text,
                style: font(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<LoginModel> loginDetails() async {
    UserRepo userRepo = UserRepo();
    var value = await userRepo.getUser();
    return value == null ? null : value;
  }
    getSearchRemaining(String token) async {
      await languageBloc.searchRemaining(token,context,).then((value) {
      setState(() {searchRemainingModel = value;});
      debugPrint("yes searchRemainingModel"+searchRemainingModel.
      responseMessage.toString());});}

  Future<LanguageList> getLanguageData() async {
    UserRepo userRepo = UserRepo();
    var value = await userRepo.getLanguage();
    if(value!=null)
    {
      List<LanguageList> languageList=new List();
      languageList.add(value);
      setState(() {
        languageModel=  LanguageModel(
          responseMessage: DemoLocalizations.of(context).trans('UI_RESPONSE_LANG_LIST_FETCHED') ,
          responseCode:200,languageList:languageList,
        );
      });
    //  languageModel.responseMessage.toast();
    }
    else{
      languageBloc.returnLanguageData(context).then((value) {
        setState(() {languageModel = value;});});
    }
    return value == null ? null : value;
  }
getAllData(){
    debugPrint("get all the data");
  loginDetails().then((value) {
    getSearchRemaining(value.result.jwtToken);
    setState(() {
      loginDetail = value;
    });
  });
  getLanguageData();
}

}
