import 'package:empowerismo/base/bloc/color_bloc.dart';
import 'package:empowerismo/base/bloc/favourite_bloc.dart';
import 'package:empowerismo/base/model/get_favourite_list_model.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
 import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowFileDialog extends StatelessWidget {
  ColorBloc colorBloc;
  FavouriteBloc favouriteBloc = new FavouriteBloc();

  LoginModel loginDetail;

  FavouriteList favouriteList;



   List<bool> colorList;

  ShowFileDialog(this.loginDetail, this.favouriteList) {
    colorBloc = ColorBloc();
    colorList = List();
    colorList = [false, false, false, false, false];
    colorBloc.ListOfColor.add(colorList);
  }

  @override
  Widget build(BuildContext context) {
    colorBloc.ListOfColor.add(colorList);

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: 40.marginAll(),
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            10.verticalSpace(),
             InkWell(
                onTap: () async {
                  Navigator.pop(context,languageConversion(context,
                      'UI_RESPONSE_RENAME') );
                  },
                child: Container(
                    //margin: 10.marginHorizontal(),
                    child: dialog(context,languageConversion(context,
                        'UI_RESPONSE_RENAME')))),
            commonDivider(
              color: borderColor,
              context: context,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
            ),
            5.verticalSpace(),
            InkWell(
              onTap: () {
                   Navigator.pop(context,languageConversion(context,
                       'UI_RESPONSE_DELETE'));
              },
              child: Container(
                child: dialog(
                  context,
                  languageConversion(context,
                    'UI_RESPONSE_DELETE'),
                ),
              ),
            ),
         /*   commonDivider(
              color: borderColor,
              context: context,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
            ),
            dialog(context, "Select Color"),
            StreamBuilder(
                stream: colorBloc.ListOfColor.stream,
                builder: (context, snapshot) {
                  return Row(children: [
                    color(blueColor,
                        snapshot.data == null ? false : snapshot.data[0],
                        function: () {
                      addSelectedColors(
                          selected_i0: true,
                          selected_i1: false,
                          selected_i2: false,
                          selected_i3: false,
                          selected_i4: false);
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
                    color(yellowColor,
                        snapshot.data == null ? false : snapshot.data[2],
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
                }),*/
            // 5.verticalSpace()
          ],
        ),
      ),
    );

    //return dialog(context);
  }

  Widget dialog(BuildContext context, String text, {Function function}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            padding: 5.paddingAll(),
            child: customText(
                 text: text,
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textDark1Color),
                margin: EdgeInsets.only(left: 5, right: 10)),
          ),
          10.verticalSpace(),
        ],
      ),
    );
  }

  Widget color(Color color, bool selected, {Function function}) {
    return selected
        ? Container(
            padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
            child: selectedColor(color: color))
        : InkWell(
            onTap: () {
              function();
            },
            child: Container(
                padding:
                    EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                child: colorWidget(
                  color: color,
                  selected: selected,
                  function: function,
                )),
          );
  }

  addSelectedColors(
      {bool selected_i0,
      bool selected_i1,
      bool selected_i2,
      bool selected_i3,
      bool selected_i4}) {
    colorList.insert(0, selected_i0);
    colorList.insert(1, selected_i1);
    colorList.insert(2, selected_i2);
    colorList.insert(3, selected_i3);
    colorList.insert(4, selected_i4);
    colorBloc.ListOfColor.add(colorList);
  }

  deleteFromFav({String id, String auth_token, BuildContext context}) async {
    var bloc =
        await favouriteBloc.deleteFavList(context,id: id, auth_token: auth_token);
    bloc.responseMessage.toast();
    if (bloc != null) Navigator.pop(context,languageConversion(context,
        'UI_RESPONSE_YES'));
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
    if (bloc != null) Navigator.pop(context, bloc);
  }
}
