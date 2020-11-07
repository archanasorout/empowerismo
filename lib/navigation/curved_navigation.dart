import 'package:empowerismo/src/common/CommonWidgets.dart';
import 'package:empowerismo/utils/Theme.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'nav_custom_painter.dart';
import 'navigation_button.dart';

class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int index;
  final Color color;
  final Color buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int> onTap;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
Widget childd;
  CurvedNavigationBar({
    Key key,
    @required this.items,
    this.childd ,
    this.index = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    this.onTap,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 60.0,
  })  : assert(items != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar>
    with SingleTickerProviderStateMixin {
  double _startingPos;
  int _endingIndex ;
  double _pos;
  double _buttonHide = 0;
  Widget _icon;
  AnimationController _animationController;
  int _length;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[1];
    _length = widget.items.length;
    _pos = 1 / _length;
    _startingPos = widget.index / _length;

   _animationController = AnimationController(vsync: this, value: _pos);
    setState(() {
      _endingIndex=widget.index;

    });

    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
     //   if(widget.index==1)
    //      {
            final endingPos = _endingIndex / widget.items.length;
            final middle = (endingPos + _startingPos) / 2;
            if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
              _icon = widget.items[_endingIndex];
            }
            _buttonHide = (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
     //    }

      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      overflow: Overflow.visible,
    alignment: Alignment.bottomCenter,
      children: <Widget>[
     /*   Container(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              debugPrint("tapppppp");
              _buttonTap(1);
            },
            child: gradient(
              height: 50,
              width: 50,
              color1:selectedIconColor,color2: purple3Color,
              radious:  30,
              child: Material(
                color: Colors.transparent,
                type: MaterialType.circle,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: _icon,
                ),),),
          ),
        ),*/

        Positioned(
          left: 0,
          right: 0,
         bottom: 5 - (60.0 - widget.height),
          child: CustomPaint(
                 painter: NavCustomPainter(
                 _pos, _length,
                 widget.color, Directionality.of(context),
                 _endingIndex,
    ),
                 child: Container(
                 height: 60.0,
                 child:widget.childd,
                              ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0 - (60.0 - widget.height),
          child: SizedBox(
              height: 100.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                //  mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.items.map((item) {
                      return
                        Expanded(
                         child:GestureDetector(
                            behavior: HitTestBehavior.translucent,
                             onTap:(){
                                _buttonTap(widget.items.indexOf(item));
                             },
                            child: Container(
                            // color: Colors.blue,
                             height: 75,
                              child: Center(
                                  child: widget.items.indexOf(item)==1?Container(): item
                              ),
                            ),
                        ),
                        )
                      ; NavButton(
                           onTap: _buttonTap,
                          position: _pos,
                          length: _length,
                          index: widget.items.indexOf(item),
                          child: Center(
                              child: item
                          ),
                      );
                    }).toList()),
              )),
        ),
        Positioned(
          bottom: 45 - (65.0 - widget.height),
          width: size.width / _length,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              debugPrint("tapppppp");
              _buttonTap(1);
            },
            child: Center(
              child: gradient(
                height: 50,
                width: 50,
                color1:selectedIconColor,color2: purple3Color,
                radious:  30,
                child: Material(
                  color: Colors.transparent,
                  type: MaterialType.circle,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    //   padding: const EdgeInsets.all(15),
                    child: _icon,
                  ),),),
            ),
          ),
        ),
       /* Positioned(
          bottom: 45 - (65.0 - widget.height),
          child: Container(
          //  height: 100,
         //   color:Colors.blue,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                debugPrint("tapppppp");
                _buttonTap(1);
              },

            child: Material(
                      color: Colors.red,

                      type: MaterialType.circle,
                      child: Container(
                       //color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          //   padding: const EdgeInsets.all(15),
                          child: Icon(Icons.search,color: Colors.black,),
                        ),
                      ),
              ),



            ),
          ),
        ),*/
      ],
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (widget.onTap != null) {
      widget.onTap(index);
      debugPrint("ontap +++"+index.toString());
    }
    widget.onTap(index);
    debugPrint("ontap outside+++"+index.toString());


    final newPosition = index / _length;
    setState(() {
     // _startingPos = _pos;
      _endingIndex = index;
/*      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);*/
    });
  }
}

class CustomStack extends Stack {
  CustomStack({children}) : super(children: children);

  @override
  CustomRenderStack createRenderObject(BuildContext context) {
    return CustomRenderStack(
      alignment:  Alignment.bottomCenter,
      textDirection: textDirection ?? Directionality.of(context),
      fit: fit,
      overflow: overflow,
    );
  }
}

class CustomRenderStack extends RenderStack {
  CustomRenderStack({alignment, textDirection, fit, overflow})
      : super(
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      );

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    var stackHit = false;

    final children = getChildrenAsList();

    for (var child in children) {
      final StackParentData childParentData = child.parentData;

      final childHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );

      if (childHit) stackHit = true;
    }

    return stackHit;
  }
}
