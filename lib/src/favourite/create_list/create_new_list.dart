 import 'package:empowerismo/base/bloc/color_bloc.dart';
import 'package:empowerismo/base/bloc/favourite_bloc.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

 class CreateNewListWidget extends StatefulWidget {
  LoginModel loginDetail;
  String title;
  String sId;
  String name;
  String color;
  int indexx;
   CreateNewListWidget(this.loginDetail,this.title, {this.sId,this.name,this.color,this.indexx});
  @override
  _CreateNewListWidgetState createState() => _CreateNewListWidgetState();
}

class _CreateNewListWidgetState extends State<CreateNewListWidget> {

  ColorBloc colorBloc;
  List<bool> colorList;
  String  colorSelect='';
  FavouriteBloc favouriteBloc=new FavouriteBloc();
  TextEditingController controller;
  _CreateNewListWidgetState() {

  }
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    colorBloc = ColorBloc();
    colorList = List();
    colorList = [widget.color==null?true:false, false, false, false, false];
    colorBloc.ListOfColor.add(colorList);
    controller =new TextEditingController();
    if(widget.name!=null) {
      setState(() {
        controller.text = widget.name;
      });
    }
    if(widget.color==null) {
      setState(() {
        colorSelect = "5481E6";
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    debugPrint("colorsss"+widget.color.toString());
    colorBloc.ListOfColor.add(colorList);
    return
       Scaffold(
        bottomNavigationBar:CustomButton(

            context,
            function:(){
              if(validate(controller.text, colorSelect,
                  widget.loginDetail.result.jwtToken,widget.name,
                  widget.color))
              {
                if(widget.title==languageConversion(context,
                    'UI_TITLE_RENAME_LIST')) {
                  renameFavList(
                    context: context,
                    id: widget.sId,
                    auth_token: widget.loginDetail.result.jwtToken,
                    name: controller.text,
                    color: colorSelect==null?widget.color:colorSelect,
              );
                }
                else {
                  createNewListWithApi(controller.text, colorSelect,
                    widget.loginDetail.result.jwtToken,
                  );
                }
              }
            },
            width: screenWidth(context),
            decoration: false,
            gradient: false,
            text:languageConversion(context,
                'UI_BUTTON_SAVE'),
            height: 45,
            radius: 25.0,
            isSingleColor: true,
            color: purple1Color,
            margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
            textStyle: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorWhite)),
        backgroundColor: colorWhite,
        appBar: EmptyAppBar(colorWhite),
        body:SingleChildScrollView(
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           topImages(context,center: true,text:widget.title,right:                          true),
                    commonDivider(
                      color: borderColor,
                      context: context,
                     ),
                    20.verticalSpace(),
                    textFiled(
                        widget.title ==languageConversion(context,
                            'UI_CREATE_NEW_LIST')
                             ?languageConversion(context,
                            'UI_NAME_LIST')
                            :"",
                    ),
                    20.verticalSpace(),
                    text(context,languageConversion(context,
                        'UI_TEXT_SELECT_COLOR')),
                     StreamBuilder(
                        stream: colorBloc.ListOfColor.stream,
                        builder: (context, snapshot) {
                          return Row(children: [
                            color(
                                blueColor,
                                snapshot.data == null ? false :
                                snapshot.data[0],
                                function: () {
                                  addSelectedColors(
                                      selected_i0: true,
                                      selected_i1: false,
                                      selected_i2: false,
                                      selected_i3: false,
                                      selected_i4: false,
                                  );
                                }),
                            color(greenColor,
                                snapshot.data == null ? false : snapshot.data[1],
                                function: () {
                                  addSelectedColors(
                                      selected_i0: false,
                                      selected_i1: true,
                                      selected_i2: false,
                                      selected_i3: false,
                                      selected_i4: false);
                                }),
                            color(
                                yellowColor,snapshot.data == null?false : snapshot.data[2],
                                function: () {
                                  addSelectedColors(
                                      selected_i0: false,
                                      selected_i1: false,
                                      selected_i2: true,
                                      selected_i3: false,
                                      selected_i4: false);
                                }),
                            color(pinkColor,
                                snapshot.data == null ? false : snapshot.data[3],
                                function: () {
                                  addSelectedColors(
                                      selected_i0: false,
                                      selected_i1: false,
                                      selected_i2: false,
                                      selected_i3: true,
                                      selected_i4: false);
                                }),
                            color(blue2Color,
                                snapshot.data == null ? false : snapshot.data[4],
                                function: () {
                                  addSelectedColors(
                                      selected_i0: false,
                                      selected_i1: false,
                                      selected_i2: false,
                                      selected_i3: false,
                                      selected_i4: true);
                                }),
                          ]);
                        }),
                    15.verticalSpace(),
                   /* createNewList(context:context,function:(){
               //    navigate(context, screen: CreateNewListWidget());
                         context.pop();
                    }, child:customText(
                      //  alignmentGeometry: Alignment.topRight,
                      text: "Add words",
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textDark1Color),
                      ),),*/
                  ],
                ),
      ),
    );
   }
  bool validate(String name, String color,String authToken,String rename,String renameColor) {
    if (name.isEmpty) {
      languageConversion(context,
          'UI_TOAST_ENTER_NAME_LIST').toast(color: colorWhite);
      return false;
    }
    else if (color.isEmpty && renameColor==null) {
      languageConversion(context,
          'UI_TOAST_SELECT_ANY_COLOR').toast(color: colorWhite);
      return false;
    } else if (authToken.isEmpty) {
      languageConversion(context,
          'UI_TOAST_AUTH_TOKEN_EMPTY')
      .toast(color: colorWhite);
      return false;
    } else
      return true;
  }
  Widget textFiled(String hint)
  {
   return
      Container(
        margin: EdgeInsets.only(left: 20,right: 20),
       padding: 15.paddingAll(),
      //  width: 100,
        //  height: 20,
        decoration: new BoxDecoration(
           color:text5Color ,
            //border: Border.all(color: text5Color),
            borderRadius: new BorderRadius.all(
              Radius.circular(5),
            )) ,
        child: TextField(
          controller: controller,
         // textAlign: TextAlign.start,
          decoration: new InputDecoration(
              isDense: true,
               contentPadding: EdgeInsets.only(bottom: -2.0),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              // contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintStyle:  GoogleFonts.lato(
                  fontSize: 16, fontWeight: FontWeight.w400, color: text10Color),
              hintText: hint

          ),
            autofocus: true,
          style:  GoogleFonts.lato(
              fontSize: 16, fontWeight: FontWeight.w400, color: textDark1Color),
        ),
      )
    ;
  }


  text(BuildContext context, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 20,
            right:20,
            top:10
          ),
         // padding: 5.paddingAll(),
          child: customText(
            //  alignmentGeometry: Alignment.topRight,
              text: text,
              style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textDark1Color),
           //   margin: EdgeInsets.only(left: 5, right: 10)

          ),
        ),
        10.verticalSpace(),
      ],
    );
  }

  createNewListWithApi(String name,String color,String auth_token) async {
    debugPrint("mmmmmmm");
    launchProgress(context: context);

    var bloc = await favouriteBloc.createNewListResponse(context,name: name,color:color,authToken: auth_token);
    disposeProgress();
    if(bloc.responseMessage==
          languageConversion(context, 'UI_RESPONSE_ADD_SUCCESSFULLY')
    ) {
      bloc.responseMessage.toast(color: purpleColor);
      /*navigate(
        context,
        isInfinity:true,
        screen: HomePage(0),
      );*/
       Navigator.pop(context,bloc.responseMessage);
    }
    else {
      bloc.responseMessage.toast(color: colorWhite);
    }
  }
  Widget color(Color color, bool selected, {Function function}) {
    return selected || widget.color!=null && color== widget.color.toColor()
        ? Container(padding: EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
          child: selectedColor(color: widget.color==null?color:widget.color.toColor(),),) : InkWell(
        onTap: (){function();},
        child: Container(
            padding: EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
            child: colorWidget(color:color,selected:selected,function:function,//margin: EdgeInsets.only(left: 1, right: 1 )
            )));
  }


  addSelectedColors(
      {bool selected_i0,
        bool selected_i1,
        bool selected_i2,
        bool selected_i3,
        bool selected_i4}) {
    setState(() {widget.color=null;});
    if(selected_i0) setState(() {colorSelect="5481E6";});
    else if(selected_i1) setState(() {colorSelect="98CB4A";});
    else if(selected_i2) setState(() {colorSelect="F7D842";});
    else if(selected_i3) setState(() {colorSelect="F15F74";});
    else{setState(() {colorSelect="2CA8C2";});}
    colorList.insert(0, selected_i0);
    colorList.insert(1, selected_i1);
    colorList.insert(2, selected_i2);
    colorList.insert(3, selected_i3);
    colorList.insert(4, selected_i4);
    colorBloc.ListOfColor.add(colorList);
  }
  renameFavList(
      {String id,
        String auth_token,
        BuildContext context,
        String name,
        String color}) async {
    var bloc = await favouriteBloc.renameFavList(context,
        id: id, auth_token: auth_token, name: name, color: color);
    bloc.responseMessage.toast();
    if (bloc != null)
      Navigator.pop(context, bloc.responseMessage);
  }
}
