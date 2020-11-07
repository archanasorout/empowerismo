import 'package:flutter/material.dart';

class ShowingWidget extends StatefulWidget {
  ShowingWidget({Key key, @required this.widget, @required this.isToast})
      : super(key: key);

  final Widget widget;
  final bool isToast;

  @override
  _ShowingWidgetState createState() => new _ShowingWidgetState();
}

class _ShowingWidgetState extends State<ShowingWidget>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    if (widget.isToast)
      return new Positioned(
          bottom: 25,
          left: 20,
          right: 20,
          child: new IgnorePointer(
            child: new Material(
              color: Colors.transparent,
              child: new Opacity(
                opacity: 1.0,
                child: widget.widget,
              ),
            ),
          ));
    else
      return Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: widget.widget,
      );
  }
}
