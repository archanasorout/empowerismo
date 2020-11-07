import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/src/common/custom_app_bar.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: EmptyAppBar(colorWhite),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topImages(context,
                center: true, text: "Menu", right: true, color: purpleColor),
             commonDivider(
              color: borderColor,
              context: context,
            ),
            10.verticalSpace(),
            text(context, "Terms of Use "),
            commonDivider(
                height: 2,
                color: border9Color,
                context: context,
                margin: EdgeInsets.only(left: 20, right: 20,)),
            text(context, "Privacy Policy"),
          ],
        )),
      ),
    );
  }

  Widget text(BuildContext context, String text) {
    return InkWell(
      onTap: (){
        launchURL("");
      },
      child: Container(
           margin: EdgeInsets.only(
            left: 20,
           ),
padding: 10.paddingAll(),
        child: customText(

            //  alignmentGeometry: Alignment.topRight,
            text: text,
            style: font(
                fontSize: 16.0, color: text6Color, fontWeight: FontWeight.w400),
           /* margin: EdgeInsets.only(
              left: 20,
              bottom: 10,
            )*/),
      ),
    );
  }
   launchURL(String url) async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
}
}
