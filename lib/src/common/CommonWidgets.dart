import 'dart:convert';
import 'dart:io';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/dashboard/home_page.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_svg/flutter_svg.dart';

Widget topImages(BuildContext context,
    {String text,
      Function function,
      rightFunction=false,
    String leftAsset,
    String RightAsset,
    bool left: false,
    bool right: true,
    bool center: true,
    bool withRightImage: false,
    Widget child,
    Color color: colorWhite,
    bool sendData: false,
      Function functionOfSearch,

    }) {
  return Container(
    height: 35,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 10.horizontalSpace(),
        left
            ? Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      if (sendData) {
                        navigate(context, isAwait: true, screen: HomePage(2));
                      } else
                       context.pop();
                    },
                    child: Container(
                      margin: 10.marginLeft(),
                      padding: 10.paddingAll(),
                       child: SvgPicture.asset(
                        leftAsset,
                        fit: BoxFit.fitHeight,
                        color: text6Color,
                      ),
                    ),
                  ),
                ),
              )
            : Expanded(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(),
                )),
        center
            ? Container(
                 child: customText(
                   alignmentGeometry: Alignment.center,
                   text: text,
                   style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: purple1Color,
                   ),
                  //  margin: 5.marginLeft()
                ),
              )
            : Container(),
        right
            ? child == null
                ? Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {

if(rightFunction)
  {
    function();
  }
else {
  context.pop();
}
                       //   context.pop();
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 20, bottom: 20, right: 20, top: 5),
                            child: Icon(
                              Icons.close,
                              color: textDark1Color,
                            )),
                      ),
                    ),
                  )
                : Expanded(
                    child: InkWell(
                      onTap:(){
                        functionOfSearch();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: 11.marginRight(),
                          padding: 9.paddingAll(),
                          child: Image.asset(
                            "assets/images/search.png",
                            fit: BoxFit.fill,
                            color: textDark1Color,
                          ),
                        ),
                      ),
                    ),
                  )
            : Expanded(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Container(),
                ))
      ],
    ),
  );
}

Widget CustomImageView(
    {@required String image,
    double height,
    bool svg = false,
    bool isNetwork = false,
    double width,
    BoxFit fit,
    Color color,
    EdgeInsets margin,
    EdgeInsets padding,
    Function function}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: svg
          ? SvgPicture.asset(
              image,
              fit: fit,
              height: height,
              width: width,
             color: color,
            )
          : isNetwork
              ? Image.network(
                  image,
                  fit: fit == null ? BoxFit.contain : fit,
                )
              : Image.asset(
                  image,
                  color: color,
                  height: height == null ? null : height,
                  width: width == null ? null : height,
                  fit: fit == null ? BoxFit.contain : fit,
                ),
    ),
  );
}

Widget transparentCircle(
    {
    //Color color = whiteTransparent,
    Color color,
    double height = 50,
    double width = 50,
    bool isSqure = false,
    Function function,
    double radius = 16.0,
    EdgeInsetsGeometry margin = const EdgeInsets.only(),
    Widget widget}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
        margin: margin,
        child: widget == null ? SizedBox() : widget,
        height: height,
        width: width,
        decoration: isSqure
            ? BoxDecoration(
                shape: BoxShape.rectangle,
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(radius)))
            : BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              )),
  );
}

Widget CustomCircleImageView(
    {String image,
    bool isNetwork = false,
    File file,
    double height = 40,
    double width = 40,
    Function function,
    EdgeInsets margin,
    bool isCircle = true}) {
  return InkWell(
    onTap: function
    ,
    child: Container(
        margin: margin,
        width: width,
        height: height,
        child: file != null
            ? CircleAvatar(
                radius: 30.0,
                backgroundImage: FileImage(file),
                backgroundColor: Colors.transparent,
              )
            : SizedBox(),
        decoration: file == null
            ? new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill, image: new AssetImage(image)))
            : BoxDecoration()),
  );
}

Widget customNetworkCircleImage(
    {String image = '',
    double radius = 40,
    double height = 40,
    double width = 40,
    EdgeInsets margin,
    Function function}) {
  return InkWell(
    onTap: function,
    child: Container(
        margin: margin,
        width: width,
        height: height,
        child:Material(
          color: Colors.white,
          elevation: 4,
          type: MaterialType.circle,
          child:image.isNotEmpty
              ?image.contains("http")?CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(image),
            backgroundColor: Colors.transparent,
          ):ClipOval(
           // clipBehavior: Clip.antiAlias,
            child:Image.memory(
              base64Decode(image),fit: BoxFit.cover,
            ),
          ) :ClipOval(
             child:new Image.asset("assets/images/profile.png",fit: BoxFit.fill,),
          )  /*ClipOval(
            child: new AssetImage("assets/images/profile.png")
          ),*/

    ),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new AssetImage("assets/images/profile.png")))
    ),
  );
}
Widget customMemoryCircleImage(
    {String image = '',
      double radius = 40,
      double height = 40,
      double width = 40,
      EdgeInsets margin,
      Function function}) {
  debugPrint("imageeee: "+image);
  return InkWell(
    onTap: function,
    child: Container(
        margin: margin,
        width: width,
        height: height,
        child: image.isNotEmpty
            ?
        ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Image.memory(
            base64Decode(image),fit: BoxFit.fill,
          ),

        )

            : SizedBox(),
         decoration: new BoxDecoration(
         // border:Border.all(color: Colors.black) ,
            shape: BoxShape.circle,
          color: Colors.red,
             image: new DecorationImage(
                fit: BoxFit.fill,
                image: new AssetImage("assets/images/profile.png"))

        )

    ),
  );
}
Widget CustomTextField({
  String hint,
  TextEditingController controller,
  Function onTextChanged,
  bool isObsure = false,
  bool enabled = true,
  bool boarder = false,
  bool focusedBorder = false,
  var prefixIcon,
  Color hintTextBackgroundColor,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextField(
    onChanged: (String value) {
      onTextChanged(value);
    },
    enabled: true,
    keyboardType: keyboardType,
    controller: controller,
    obscureText: isObsure,
    decoration: enabled
        ? new InputDecoration(
            fillColor: Colors.white,
            enabledBorder: boarder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                        //   color: color,
                        ),
                  ),
            focusedBorder: focusedBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )
                : null,
            prefixIcon: prefixIcon == null
                ? null
                : Container(
                    width: 0,
                    child: Row(
                      children: <Widget>[
                        Icon(prefixIcon)
                        /* CustomImageView(
                            image: prefixIcon,
                            height: 18,
                            width: 18,
                            color: Colors.white38),*/
                      ],
                    ),
                  ),
            labelText: hint,
            labelStyle: TextStyle(color: hintTextBackgroundColor),
            contentPadding:
                EdgeInsets.only(bottom: 0, top: 0, left: boarder ? 16 : 0.0),
            /*hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white,

        )*/
          )
        : InputDecoration.collapsed(
            hintText: hint,
            hintStyle: TextStyle(color: hintTextBackgroundColor)),
    style: TextStyle(
        //fontWeight: FontWeight.bold,
        //    color: navigationIconColor
        ),
  );
}

Widget searchButton(BuildContext context, TextEditingController search_editing_controller,{
  Function function(value),
  String asset,String name,
  Function selecteLanguage,
  String sourceLanguage

} ) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
     child: CustomTextFieldWithBackgroundColor(

      functionForEditText: (value){
      return  function(value);
      },
      controller: search_editing_controller,
      decorationColor: white1Color,
      decorationBorderColor: white2Color,
      prefix: CustomImageView(
          margin: EdgeInsets.only(left: 20, right: 5),
          width: 15,
          height: 15,
          image: "assets/images/search.png",
          svg: false,
          color: textColor,
          fit: BoxFit.fill),
      hintStyle:

          font(fontSize: 16.0, color: textColor, fontWeight: FontWeight.w600),
      textStyle: font(
          fontSize: 16.0, color: textDark1Color, fontWeight: FontWeight.w600),
          radious: 5.0,
       padding: EdgeInsets.only(top: 10),
      hint: languageConversion(context,
          'UI_TEXT_SEARCH_HERE') ,
      columnChild: Column(
        children: [
          commonDivider(
              color: border9Color,
              context: context,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              )),
          InkWell(
            onTap: (){
              selecteLanguage();
            },

            child: Row(
                children: [
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      countryWidget(false,null,sourceLanguage),
                      CustomImageView(
                          color: textLight1Color,
                          height: 10,
                          width: 15,
                          image: "assets/images/right_arrow.svg",
                          svg: true,
                          /*color: purpleColor,*/
                          margin: EdgeInsets.only(right: 20),
                          fit: BoxFit.fill),
                    ]),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      countryWidget(false,asset,name),
                      CustomImageView(
                          color: textLight1Color,
                          height: 5,
                          width: 8,
                          image: "assets/images/down_arrow.svg",
                          svg: true,
                          fit: BoxFit.fill,
                          margin: EdgeInsets.only(right: 20))
                    ]),
              )
            ]),
          ),
          20.verticalSpace(),
        ],
      ),
    ),
  );
}

Widget countryWidget(bool dropDown,String asset,String name) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        asset!=null?customNetworkCircleImage(
          //margin: 1.marginAll(),
          height: 20,
          width: 20,
          image: asset,
        ):
        CustomCircleImageView(
            image: 'assets/images/german_flag.png',
            file: null,
            height: 20,
            width: 20),
        /*CustomCircleImageView(
            // margin: 1.marginAll(),
            *//* function: () {
                pickImage();
              },*//*
            image: 'assets/images/german_flag.png',
            file: null,
            height: 20,
            width: 20),*/
        customText(
            function: () {
              //  navigate(context, screen: DictonaryWidget());
            },
            //  alignmentGeometry: Alignment.topRight,
            text: name,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textStyle: TextStyle(
                color: textDarkColor,
              ),
            ),
            /*TextStyle(
              // fontWeight: FontWeight.bold,
               color: textDarkColor,
               fontSize: 16,
             ),*/
            margin: EdgeInsets.only(
              left: 5,
            )),
      ],
    ),
  );
}

Widget CustomTextFieldWithBackgroundColor(
    {bool boundryColor = false,
    Function function,
    Function functionForEditText(value),
    Color decorationBorderColor = Colors.white,
    Color decorationColor = Colors.white,
    Widget prefix,
    Widget leading,
    String hint,
    TextStyle hintStyle,
    TextStyle textStyle,
    double radious = 10.0,
    TextEditingController controller,
    Function onTextChanged,
    bool isObsure = false,
    bool isdecorationColor = true,
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    Widget columnChild,
    bool textField = true,
    TextInputType keyboardType = TextInputType.text}) {
  return new Container(
      margin: margin,
      padding: padding,
      decoration: new BoxDecoration(
          border:
              boundryColor ? Border.all(color: decorationBorderColor) : null,
          color: isdecorationColor ? decorationColor : null,
          borderRadius: new BorderRadius.all(
            Radius.circular(radious),
          )),
      child: Column(

        children: [
          //18.verticalSpace(),

          Row(
             children: [
              prefix == null ? Container() : prefix,
              5.horizontalSpace(),
              Expanded(
                child: InkWell(
                  onTap: () {
                    function();
                  },
                  child: textField
                      ? new TextField(






onChanged: (value){
 debugPrint("value of edit text:::"+value);
 functionForEditText(value);
},
                    autofocus: true,
                          controller: controller,
                          textAlign: TextAlign.start,
                          decoration: new InputDecoration(
                            hintText: hint,
                            hintStyle: hintStyle == null
                                ? TextStyle(
                                    fontSize: 18.0, color: Color(0xFFdce0e3))
                                : hintStyle,
                            border: InputBorder.none,
                          ),
                          obscureText: isObsure,
                          style: textStyle,
                        )
                      : customText(
                          function: () {
                            function();
                          },
                          alignmentGeometry: Alignment.topLeft,
                          text: hint,
                          style: hintStyle == null
                              ? TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  color: textDark1Color,
                                  fontSize: 16,
                                )
                              : hintStyle,
                          //margin: EdgeInsets.only(left: 15, bottom: 10)
                        ),
                ),
              ),
              leading == null ? Container() : leading
            ],
          ),
          columnChild == null ? Container() : columnChild
        ],
      ));
}

Widget customIcon(
    {EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    IconData icon,
    Function function,
    Color color = Colors.black,
    double size = 25}) {
  return GestureDetector(
    onTap: function,
    child: Container(
        padding: padding,
        margin: margin,
        child: Icon(
          icon,
          color: color,
          size: size,
        )),
  );
}

customDialog(
  BuildContext context, {
    Function onDismiss,
  Widget widget = const Text('Pass sub widgets'),
}) async {
 var data = await showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
          alignment: Alignment.center,
          child: widget
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim),
  child: child,
  );
},
);
 onDismiss(data);
}

Widget customRow(
    {Widget child1, Widget child2, Widget column, Widget divider}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child1,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            child2,
            column == null ? Container() : column,
            divider == null ? Container() : divider,
          ],
        )
      ]);
}

Widget selectedColor(
    {Color color,
    EdgeInsetsGeometry margin }) {
  return Container(
    //margin: 20.marginAll(),
    margin: margin,

    child: Stack(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            //color: Colors.blue,
            border: Border.all(color: color),
            borderRadius: new BorderRadius.all(Radius.circular(20)),
          ),
        ),
        Positioned(
          top: 3,
          left: 3,
          right: 3,
          bottom: 3,
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: new BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget colorWidget({
  Color color,
  bool selected,
  Function function,
  EdgeInsetsGeometry margin
}) {
  return InkWell(
   /* onTap: () {
      //function();
    },*/
    child: Container(
       margin: margin,
      height: 15,
       width: 15,
      decoration: BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}

Widget commonDivider({
  EdgeInsetsGeometry margin,
  BuildContext context,
  Color color,
  double width,
  double height = 1.0,
}) {
  return Container(
      margin: margin,
      color: color,
      height: height,
      width: width == null ? screenWidth(context) : width);
}

circleButton(
    {AlignmentGeometry alignmentGeometry = Alignment.topLeft,
    Widget child,
    Color color = Colors.transparent,
    Function function,
    BuildContext context,
    EdgeInsetsGeometry margin = const EdgeInsets.all(20.0)}) {
  return InkWell(
    onTap: () {
      //Navigator.pop(context);
      //function();
    },
    child: Container(
        //height: 40,
        //width: 40,
        margin: margin,
        alignment: alignmentGeometry,
        child: new SizedBox(
            height: 40,
            width: 40,
            child: FloatingActionButton(
              elevation: 1,
              backgroundColor: color,
              child: child == null ? Icon(Icons.arrow_back) : child,
              onPressed: () {
                if (child == null) Navigator.pop(context);

                print("Clicked");
              },
            ))),
  );
}

Widget customText(
    {@required TextStyle style,
    int maxLine: 2,
    Function function,
    Color color,
    AlignmentGeometry alignmentGeometry,
    TextAlign textAlign = TextAlign.center,
    @required String text,
    var hint,
    EdgeInsetsGeometry margin}) {
  return InkWell(
    onTap: function,
    child: Container(
        margin: margin,
        alignment: alignmentGeometry,
        child: Container(
            color: color,
            child: new Text(
              text,
              style: style,
              textAlign: textAlign,
              maxLines: maxLine,
              overflow: TextOverflow.ellipsis,
            ))),
  );
}

Widget CustomButton(BuildContext context,
    {double width,
    Gradient gradientColor,
    Color backgroundColor: colorWhite,
    bool gradient = true,
    bool border = true,
    bool borderWithBackgroundColor = false,
    bool decoration = false,
    double height = 45,
    String text,
    Function function,
    IconData icon,
    bool isActive = true,
    bool isSingleColor = false,
    Color color,
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    TextStyle textStyle,
    double radius}) {
  return InkWell(
    onTap: function,
    child: Container(
      height: height,
      margin: margin,
      padding: padding,
      child: Center(
        child: Text(
          text,
          style: textStyle == null
              ? TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.0)
              : textStyle,
          textAlign: TextAlign.center,
        ),
      ),
      decoration: decoration
          ? BoxDecoration(
              color: borderWithBackgroundColor
                  ? backgroundColor
                  : gradient ? null : border ? null : color,
              border: border ? Border.all(color: color) : null,
              borderRadius: new BorderRadius.all(

                  Radius.circular(radius == null ? 4.0 : radius)),
            )
          : BoxDecoration(
              color: color,
              borderRadius: new BorderRadius.all(
                  Radius.circular(radius == null ? 4.0 : radius)),
            ),
      width: width == null ? screenWidth(context) : width,
    ),
  );
}

CustomCard(
    {@required Widget child,
    double height,
    double width,
    EdgeInsets margin = const EdgeInsets.all(0),
    EdgeInsets padding = const EdgeInsets.all(0)}) {
  return Card(
    margin: margin,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Container(
      padding: padding,
      child: child,
      height: height,
      width: width,
    ),
  );
}

Widget gradient(
    {@required Widget child,
    BuildContext context,
    Color color1,
    Color color2,
    double height,
    double width,
    double radious}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      // borderRadius: new BorderRadius.all(Radius.circular(20),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

          stops: [
            0.1,
            0.6,
            //  0.9,
          ],
          colors: [
            color1,
            color2,
            // lightColorOrange,
          ]),
      borderRadius: BorderRadius.circular(radious),
    ),
    child: child,
  );
}

Widget createNewList({BuildContext context, Function function, Widget child}) {
  return Row(
    children: [
      Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          padding: 15.paddingAll(),
            decoration: new BoxDecoration(
               border: Border.all(color: border2Color),
              borderRadius: new BorderRadius.all(
                Radius.circular(6),
              )),
          child: customIcon(
             size: 20,
            icon: Icons.add,
            color: iconColor,
          ),
        ),

      child
    ],
  );
}

customListt(
    {Widget child(index) ,
      var list = const [],
      GestureTapCallback function({index}),
      Axis axis = Axis.vertical}) {
  debugPrint("jhsdjsgbcjhdgbvchj");
  return ListView.builder(
      padding: EdgeInsets.all(0.0),
       physics: ScrollPhysics(),
      scrollDirection: axis,
      shrinkWrap: true,
      itemBuilder:
          (context, index) =>
      InkWell(onTap: function==null?function:(){
        function(index:index);
      }, child: Container(child:child==null?Container():child(index))),
      itemCount: list.length > 0 ? list.length : 5,
      //controller: listScrollController,
    );
}
