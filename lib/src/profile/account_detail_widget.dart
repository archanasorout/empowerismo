import 'dart:io';
import 'package:empowerismo/base/bloc/profile_bloc.dart';
import 'package:empowerismo/base/bloc/util_bloc.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/authentication/change_password.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/UserRepository.dart';
import 'package:empowerismo/utils/Util.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;
import 'dart:convert';

class AccountDetailWidget extends StatefulWidget {
  LoginModel loginDetail;

  AccountDetailWidget(this.loginDetail);

  @override
  _AccountDetailWidgetState createState() => _AccountDetailWidgetState();
}

class _AccountDetailWidgetState extends State<AccountDetailWidget> {
  String image;
  String name;
  var utilBloc = UtilBloc();
  var profileBloc = ProfileBloc();
  List<String> listOfchanges = List<String>();
  UserRepo userRepo = new UserRepo();

  TextEditingController name_controller = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: EmptyAppBar(colorWhite),
      body:  WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
        child: Container(
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topImages(context, center: true,
                    text:languageConversion(context,
                        'UI_TITLE_ACCOUNT_DETAILS'),
                    right: false,
                    left: true,
                    leftAsset: "assets/images/left_arrow.svg",
                    sendData: sendDataOrNot()

                  ),
                  commonDivider(
                    color: borderColor,
                    context: context,
                  ),
                  profile(context),
                  commonDivider(
                      color: borderColor,
                      context: context,
                      margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20)),
                  15.verticalSpace(),
                  StreamBuilder(
                      stream: profileBloc.ListOfChanges.stream,
                      builder: (context, snapshot) {
                        return Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            //padding: 20.paddingAll(),
                            decoration: new BoxDecoration(
                              //color:decorationColor ,
                                border: Border.all(color: border2Color),
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: Column(children: [
                              5.verticalSpace(),
                              list(
                                  context,
                                  languageConversion(context,
                                      'UI_TEXT_NAME'), name == null
                                  ? nameOfUser() : name, snapshot.data == null
                                  ? languageConversion(context,
                                  'UI_TEXT_EDIT') : snapshot.data[0] == "true"
                                  ?languageConversion(context,
                                  'UI_BUTTON_SAVE') :languageConversion(context,
                                  'UI_TEXT_EDIT'),
                                  function: () {
                                  /*  if(name!=null)
                                    {
                                    setState((){
                                    name_controller.text=name;
                                    });
                                    }
                                    else{
                                      setState((){
                                    name_controller.text=widget.loginDetail.result.name;
                                    name_controller.selection = TextSelection.fromPosition(TextPosition(offset: name_controller.text.length)

                                    );
                                    });
                                    }*/
                                    if (snapshot.data == null) {
                                      setState((){
                                        name_controller.text=widget.loginDetail.
                                        result.name;
                                        name_controller.selection = TextSelection.fromPosition(
                                            TextPosition(offset: name_controller.text.length)

                                        );
                                      });
                                      listOfchanges.insert(0, "true");

                                      profileBloc.ListOfChanges.add(
                                          listOfchanges);
                                    }
                                    else if (snapshot.data[0] == "true") {
                                      listOfchanges.insert(0, "false");
                                      profileBloc.ListOfChanges.add(
                                          listOfchanges);
                                      if (name_controller.text.length >0) {
                                        debugPrint("lenght of item" +
                                            name_controller.text);

                                        setState(() {
                                          name = name_controller.text;
                                        });
                                        updateProfile(
                                            name: name_controller.text,
                                            id: widget.loginDetail.result.sId,
                                            authToken: widget.loginDetail.result
                                                .jwtToken,
                                            context: context);
                                      }
                                    }
                                    else if (snapshot.data[0] == "false") {
                                      listOfchanges.insert(0, "true");
                                      profileBloc.ListOfChanges.add(
                                          listOfchanges);
                                    }
                                  },
                                  edit: snapshot.data == null
                                      ? "false"
                                      : snapshot.data[0]),
                              commonDivider(
                                  color: borderColor,
                                  context: context,
                                  margin: EdgeInsets.only(left: 10, right: 10)),
                              list(context,languageConversion(context,
                                  "UI_PASSWORD"), "*******",languageConversion(context, "UI_TEXT_CHANGE"),function: (){
                                navigate(context, screen:
                                ChangePasswordPage(widget.loginDetail.result));

                              }),
                              commonDivider(
                                  color: borderColor,
                                  context: context,
                                  margin: EdgeInsets.only(left: 10, right: 10)),
                              list(context,
                                  languageConversion(context, "UI_TEXT_EMAIL"), widget.loginDetail.result.email,
                                  languageConversion(context, "UI_TEXT_VERIFIED")),
                              5.verticalSpace(),
                            ]));
                      }),
                ],
              )),
        ),
      ),
    );
  }

  editFunction() {}

  Widget list(BuildContext context, String text1, String text2, String text3,
      {Function function, String edit: "false"}) {
    return Container(
       margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customText(
            margin: 10.marginRight(),
            alignmentGeometry: Alignment.topLeft,
            text: text1,
            style: GoogleFonts.lato(
                fontSize: 14, fontWeight: FontWeight.w400, color: text6Color),
          ),

          edit == "true"
              ? Expanded(child: Align(
              alignment: Alignment.topCenter,
              child: textFiled(widget.loginDetail.result.name, name_controller)))
              : Expanded(
                child: customText(
            alignmentGeometry: Alignment.topCenter,
            maxLine: 1,
            text: text2,
            style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: text9Color),
            //margin: EdgeInsets.only(left: 60,bottom: 10, )
          ),
              ),

          InkWell(
            onTap: () {
              function();
            },
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: customText(
                /* function: () {
                  function();
                },*/
                margin:EdgeInsets.only(left: 10, ) ,

                alignmentGeometry: Alignment.topRight,
                text: text3,
                style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: text8Color),
              ),
            ),
          ),
          // )
        ],
      ),
    );
  }

  Widget text(String text) {
    return customText(
      alignmentGeometry: Alignment.topLeft,

      text: text,
      style: GoogleFonts.lato(
          fontSize: 16, fontWeight: FontWeight.w600, color: text6Color),
      //margin: EdgeInsets.only(left: 60,bottom: 10, )
    );
  }

  Widget textFiled(String hint, TextEditingController controller) {
  /*  if(name!=null)
      {
        setState((){
        name_controller.text=name;
        });
      }
    else{

      setState((){
        name_controller.text=widget.loginDetail.result.name;
        name_controller.selection = TextSelection.fromPosition(TextPosition(offset: name_controller.text.length));
      });
    }*/
  return Container(
      width: 100,
      margin: 10.marginLeft(),
      //  height: 20,
      child: TextField(
         textAlign: TextAlign.center,
        decoration: new InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: -2.0),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            // contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          /*  hintStyle: GoogleFonts.lato(
                fontSize: 16, fontWeight: FontWeight.w400, color: text9Color),*/
           // hintText: hint

        ),
        controller: name_controller,

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
                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      userImage(),
                      Positioned(
                        left: 32,
                        top: 67,
                        child:Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:BorderRadius.all(
                                  Radius.circular(20),
                                )
                            ),
                            child: Icon(
                              Icons.add_circle,color: purple5Color,
                              size: 25,)
                        ),
                      ),
                    ],
                  ),
                ),
                10.horizontalSpace(),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(name == null ? nameOfUser() : name),
                      customText(
                        alignmentGeometry: Alignment.topLeft,
                        text: gmailOfUser(),
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: text7Color),
                      ),
                    ])
              ],
            ),
          );
        });
  }

  Future<void> pickImage() async {
    var d = await ImagePicker().getImage(source: ImageSource.gallery);
    image = d.path;
    utilBloc.string(value: d.path);

    final bytes = Io.File(d.path).readAsBytesSync();
    String base64Encode = base64.encode(bytes);
    if(base64Encode!=null)
      convertImage(base64Encode);
    updateProfile(
        name: widget.loginDetail.result.name,
        id: widget.loginDetail.result.sId,
        authToken: widget.loginDetail.result
            .jwtToken,
        image:base64Encode,
        context: context);


  }
convertImage(String image) async {
  final decodedBytes = base64Decode(image);
//  var file = Io.File(image);
  //file.writeAsBytesSync(decodedBytes);
 // debugPrint("fileeee"+file.toString());
}

  Future<void> updateProfile(
      {String name, String id, String authToken,String image, BuildContext context}) async {
    // launchProgress(context: context); disposeProgress();
    var bloc = await ProfileBloc()
        .updateProfile(context,name: name, id: id, authToken: authToken,image:image);
    //disposeProgress();
    debugPrint("ProfilePage:: response of update profile" +
        bloc.responseCode.toString());
    debugPrint("ProfilePage:: response of update profile" +
        bloc.responseMessage.toString());

    bloc.responseMessage.toast();
    if (bloc.responseCode == 200) {
      var isSave = await userRepo.saveUser(bloc);
      if (isSave)
        debugPrint("ProfilePage:: data save in shareprefrence in flutter" +
            bloc.result.name);
      else
        debugPrint("ProfilePage:: data not save in shareprefrence in flutter");
    }
  }

  Widget userImage() {
    return image == null
        ?customNetworkCircleImage(
        margin: EdgeInsets.all(8),
        height: 70,
        width: 70,
        image: widget.loginDetail.result?.profilePicture.isEmpty
            ? ""
            : widget.loginDetail.result?.profilePicture)
        : CustomCircleImageView(
        margin: EdgeInsets.all(8),
        image: 'assets/images/profile.png',
        file: image == null ? null : File(image),
        height: 70,
        width: 70);
  }

  nameOfUser() {
    if (widget.loginDetail.result != null)
      return widget.loginDetail.result.name;
    else
      return "";
  }

  gmailOfUser() {
    if (widget.loginDetail.result != null)
      return widget.loginDetail.result.email;
    else
      return "";
  }

  sendDataOrNot()
  {
    if(image!=null  || name !=null)
      return true;
      else
      return false;
  }
}
