import 'dart:io';

import 'package:empowerismo/base/bloc/favourite_bloc.dart';
import 'package:empowerismo/base/model/login_model.dart';
import 'package:empowerismo/base/repo/favourite_repo.dart';
import 'package:empowerismo/extensions/UtilExtensions.dart';
import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/utils/Theme.dart';
import 'package:empowerismo/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class RemoveUnfavouriteDialog extends StatelessWidget {
  FavouriteBloc favouriteBloc = new FavouriteBloc();
  FavouriteRepo favouriteRepo=new FavouriteRepo();
  String wordId;
  String listId;
  LoginModel loginDetail;
  Directory tempDir;

  Directory appDocDir;
  RemoveUnfavouriteDialog(this.wordId, this.listId, this.loginDetail,){
    initilize();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: border8Color),
          color: colorWhite,
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: 40.marginAll(),
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //    50.verticalSpace(),
            InkWell(
                onTap: () {
                  if (wordId != null && listId != null &&
                      loginDetail.result.jwtToken != null)
                    // if(!mounted) return;

                    removeWordFromList(
                      wordId: wordId, listId: listId,
                      authToken: loginDetail.result.jwtToken, context: context,
                    );
                },
                child: Container(
                    child: dialog(context, languageConversion(context,
                        'UI_TEXT_UNFAVOUITE'))

                )),
            commonDivider(
              height: 1,
              color: borderColor,
              context: context,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
            ),
            InkWell(
              onTap: () async {
                var status = await checkPermission();
                if(status)
                  exportWordApi(authToken: loginDetail.result.jwtToken,
                  word_Id:wordId,
                  context: context,);
              },
              child: dialog(context, languageConversion(context,
                  'UI_TEXT_DOWNLOAD')),
            ),
            /*  commonDivider(
              height: 1,
              color: borderColor,
              context: context,
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
            ),
            dialog(context, "Print"),*/

          ],
        ),
      ),
    );

    //return dialog(context);
  }

  Widget dialog(BuildContext context, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.verticalSpace(),

        Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          padding: 5.paddingAll(),
          child: customText(
            //  alignmentGeometry: Alignment.topRight,
              text: text,
              style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textDark1Color),
              margin: EdgeInsets.only(left: 5, right: 10)),
        ),
        10.verticalSpace(),
      ],
    );
  }

  removeWordFromList({
    String listId,
    String wordId,
    String authToken,
    BuildContext context,
  }) async {
    debugPrint("list id::" + listId);
    debugPrint("wordId::" + wordId);
    debugPrint("authToken::" + authToken);
    launchProgress(context: context);
    var bloc = await favouriteBloc.removeWordFromFavList(context,
      list_id: listId, word_id: wordId, auth_token: authToken,);
    disposeProgress();
    bloc.responseMessage.toast();
    if (bloc != null)
      Navigator.pop(context, bloc.responseMessage);
  }

  exportWordApi({
    String authToken,
    String word_Id,
    BuildContext context,
  }) async {
      debugPrint("authToken::" + authToken);
    launchProgress(context: context);
    var bloc = await favouriteRepo.exportWordApi(context, auth_token: authToken,word_Id:word_Id );
    if (bloc != null)
      appDocDir = await getExternalStorageDirectory();
      debugPrint("appDocDir"+appDocDir.path);
      debugPrint("downloadUrl"+bloc.downloadUrl.toString());

      final taskId = await FlutterDownloader.enqueue(
        url:bloc.downloadUrl,
        savedDir: appDocDir.path,
        showNotification: true,
        openFileFromNotification: true,
      ).catchError((error){
        disposeProgress();
        error.toast();
      }).then((value){
        disposeProgress();
        Navigator.pop(context, bloc.responseMessage);
        debugPrint("Task idd"+value.toString());
        languageConversion(context,
            'UI_PDF_DOWNLOAD_SUCCESSFULLY').toast();
      });
      debugPrint("Task idd"+taskId.toString());

      FlutterDownloader.open(taskId: taskId);
  }
initilize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
}
 }
