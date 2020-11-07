import 'package:empowerismo/base/bloc/language_bloc.dart';
import 'package:empowerismo/base/model/language_model.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:empowerismo/utils/Util.dart';

class DictionaryWidget extends StatefulWidget {
  bool isleftArrow;
  DictionaryWidget(this.isleftArrow);
  @override
  _DictionaryWidgetState createState() => _DictionaryWidgetState();
}

class _DictionaryWidgetState extends State<DictionaryWidget> {
  UserRepo userRepo = new UserRepo();

  LanguageBloc languageBloc;
  LanguageModel languageModel;
  _DictionaryWidgetState(){
    languageBloc =new LanguageBloc();
    languageBloc.getLanguage(context);
  }
  @override
  Widget build(BuildContext context) {
            return Scaffold(
            backgroundColor: colorWhite,
            appBar: EmptyAppBar(colorWhite),
            body:_body(context)
            );
 }
_body(BuildContext context){
 return  StreamBuilder<LanguageModel>(
      stream: languageBloc.languageModel.stream,
      builder: (context, snapshot)
 {
   if (snapshot.hasData)
   {
     if(snapshot.data.responseMessage==languageConversion(context,
         'UI_RESPONSE_LANG_LIST_FETCHED'))
       {
          return Container(
           child: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   topImages(
                     context,
                     center: true,
                     text: "Select Dictionary",
                     right: widget.isleftArrow?false:true,
                     color: purpleColor,
                     leftAsset:"assets/images/left_arrow.svg",
                     left: widget.isleftArrow,
                   ),
                   commonDivider(
                     color: borderColor,
                     context: context,
                   ),
                   10.verticalSpace(),
               ListView.builder(
                 padding: EdgeInsets.all(  0.0),
                 //reverse:true,
                 physics: ScrollPhysics(),
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                 itemCount: snapshot.data.languageList.length,
                 itemBuilder:
                     (context, index) =>
                 InkWell(
                     onTap:() async {
                     var isSave=
                     await userRepo.saveLanguage(snapshot.data.languageList[index]);
                     if(isSave)
                      // "save dataa".toast();
                       Navigator.pop(context, snapshot.data.languageList[index]);
                     }  ,
                     child: itemList(context,snapshot.data.languageList,index),
                   )

               )],
               )),
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
      });

}
  itemList(BuildContext context, languageList, int index,  ) {
    return Column(
      children: [
        10.verticalSpace(),
        dictonaryWidget(context,languageList,index),
        10.verticalSpace(),
        commonDivider(
            color: borderColor,
            context: context,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ],
    );
  }

  Widget dictonaryWidget(BuildContext context, languageList, int  index) {
    return InkWell(
    /*  onTap: () {
        Navigator.pop(context, languageList[index]);

   //     navigate(context, screen: SearchWidget(languageList:languageList[index]));
      },*/
      child: Row(
        children: [
          20.horizontalSpace(),
        customNetworkCircleImage(
          margin: 1.marginAll(),
          height: 20,
          width: 20,
          image: languageList[index].targetLanguageFlag,
        ),
          /*CustomCircleImageView(
              margin: 1.marginAll(),
              *//* function: () {
                pickImage();
              },*//*
              image: 'assets/images/german_flag.png',
              file: null,
              height: 18,
              width: 18),*/
          customText(
              //  alignmentGeometry: Alignment.topRight,
              text:  languageList[index].targetLanguage,
              style: GoogleFonts.lato(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: textDarkColor),
              margin: EdgeInsets.only(left: 10, right: 10)),
          customText(
              //  alignmentGeometry: Alignment.topRight,
              text: languageList[index].targetLanguageLocalised,
              style: GoogleFonts.lato(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: light1Color),
              margin: EdgeInsets.only(left: 5, right: 10)),
        ],
      ),
    );
  }
}
