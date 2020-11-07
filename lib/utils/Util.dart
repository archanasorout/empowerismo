import 'dart:async';
import 'package:empowerismo/extensions/UtilExtensions.dart';

import 'dart:math';
import 'package:empowerismo/animations/SlideRightRoute.dart';
import 'package:empowerismo/language/demoLocalizations.dart';
import 'package:empowerismo/utils/progessdialog/WidgetPosition.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


import 'Theme.dart';
String errorMessage = 'Something went Wrong';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
font({Color color,double fontSize,FontWeight fontWeight,FontStyle fontStyle})
{
 return GoogleFonts.lato(
   fontStyle: fontStyle,
    fontSize: fontSize,
    fontWeight: fontWeight,
    textStyle: TextStyle(color: color, ),
  );
}
/*statusBar(Color color)  {
   FlutterStatusbarcolor.setStatusBarColor(color);
  if (useWhiteForeground(color)) {
    debugPrint("yessss");

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    debugPrint("noo");

    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }

}*/

void showPopup(BuildContext context,Widget child) {
  showDialog(
    context: context,
    builder: (_) => child ,
  );
}


double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

navigate(BuildContext context,
    {@required Widget screen,
    bool isAwait = false,
    bool isRemove = false,
    bool isInfinity = false}) async {
  if (isRemove)
    Navigator.pushReplacement(context, EnterExitRoute(enterPage: screen));
  else if (isAwait)
    return await Navigator.push(context, EnterExitRoute(enterPage: screen));
  else if (isInfinity) {

    logOut(context: context, screen: screen);
  }
  else
    Navigator.push(context, EnterExitRoute(enterPage: screen));
}
navigateWithExit(BuildContext context,
    {@required Widget screen,
    bool isAwait = false,
    bool isRemove = false,
    bool isInfinity = false}) async {
  if (isRemove)
    Navigator.pushReplacement(context, EnterExitRoute(exitPage: screen));
  else if (isAwait)
    return await Navigator.push(context, EnterExitRoute(exitPage: screen));
  else if (isInfinity) {

    logOut(context: context, screen: screen);
  }
  else
    Navigator.push(context, EnterExitRoute(exitPage: screen));
}

Future<Position> currentLocation = getLocation();

Future<Position> getLocation() async {
  Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  return position;
}
Future<bool> checkPermission() async {
  var status = await Permission.storage.status;
  debugPrint("status of storage"+status.isGranted.toString());
  if(status.isGranted)
    {return true;}
 else{
  var isPermission= await Permission.storage.request();
  if(isPermission.isGranted)
    {
      return true;
    }
  else
    return false;
  }
}
Future logOut({Widget screen, BuildContext context}) async {
  Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return screen;
      }, transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }),
      (Route route) => false);
}

bool validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,15}$)';
  RegExp regExp = new RegExp(patttern);
  return regExp.hasMatch(value);
}
String languageConversion(BuildContext context,String text){
 return DemoLocalizations.of(context).trans(text);
}
double getstatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}
snackBar({BuildContext context,String text}){

  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: purpleColor,
    content: Text(text),
  ));
}
bool validate(String email, String password,BuildContext context ) {
  if (email.isEmpty) {
     DemoLocalizations.of(context).trans('VALIDATION_ENTER_EMAIL').toast();
    return false;
  } else if (!isEmail(email)) {
    DemoLocalizations.of(context).trans('VALIDATION_ENTER_VALID_EMAIL_ADDRESS').toast();
    return false;
  } else if (password.isEmpty) {
    DemoLocalizations.of(context).trans('VALIDATION_ENTER_YOUR_PASSWORD').toast();
    return false;
  } else
    return true;
}
bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

String randomString(int strlen) {
  var alpha =
      "ARBAEROMCBHAKJJNKKWROJOAIIAHRAMNSNDFNWNNWNXBFBWFEWUEWBBEUWEWBFBWBZKAKKNAKNBWWARAHNAKNAN";
  var numeric = "1234567890987654321123451234567890678900987654321";

  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 1; i < strlen + 1; i++) {
    if (i % 2 == 0)
      result += alpha[rnd.nextInt(alpha.length)];
    else
      result += numeric[rnd.nextInt(numeric.length)];
  }
  return result;
}

   WidgetPosition overlay = new WidgetPosition();

   launchProgress(
      {@required BuildContext context,
       String message = 'Processing..',
      bool isWhite = false}) async {
    overlay.show(
        context: context,
        isToast: false,
        externalBuilder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black54,
            body: Container(
                height: MediaQuery.of(context).size.height,
                child: new Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(purpleColor),

                 //   backgroundColor: purpleColor,
                  ),
                )),
          )
          ;
        });
  }

     showOverlay({BuildContext context, Widget widget}) async {
    overlay.show(
        context: context,
        isToast: false,
        externalBuilder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/overlay@3x.png'),
                        fit: BoxFit.fill)),
                height: MediaQuery.of(context).size.height,
                width: screenWidth(context),
                child: widget),
          );
        });
  }

    disposeProgress() {
    if (overlay != null) overlay.hide();
  }

