import 'package:empowerismo/utils/progessdialog/ShowingWidget.dart';
import 'package:flutter/material.dart';

class WidgetPosition {
  bool _isVisible = false;
  OverlayEntry overlayEntry;

  void show({
    @required BuildContext context,
    @required WidgetBuilder externalBuilder,
    @required bool isToast,
    Duration duration = const Duration(seconds: 2),
  }) async {
    if (_isVisible) {
      return;
    }

    _isVisible = true;

    OverlayState overlayState = Overlay.of(context);

    overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => new ShowingWidget(
        widget: externalBuilder(context),
        isToast: isToast,
      ),
    );
    overlayState.insert(overlayEntry);
  }

  hide() {
    if (overlayEntry != null && _isVisible) {
      overlayEntry?.remove();

      _isVisible = false;
    }
  }
}
