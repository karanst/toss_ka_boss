import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';


import 'colors.dart';
import 'constant.dart';
Row rowWith2Text({required title, required value}) {
  return Row(
    children: [
      text(title ?? "N/A", fontSize: 10.sp),
      Spacer(),
      text(value ?? "N/A", fontSize: 10.sp)
    ],
  );
}
Widget fourthBanner(BuildContext context) {
  return proImage!=""?Center(
    child: InkWell(
      onTap: (){

      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: getWidth(680),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: MyColorName.colorBg1,
          ),
          child: commonImage(
              proImage, 200.0, 680.0, "", context, "images/banner.png"),
        ),
      ),
    ),
  ):SizedBox();
}
Widget text(String text,
    {var fontSize = textSizeMedium,
      textColor = const Color(0xffffffff),
      var fontFamily = fontRegular,
      var isCentered = false,
      var isEnd = false,
      var maxLine = 2,
      var latterSpacing = 0.25,
      var textAllCaps = false,
      var isLongText = false,
      var overFlow = false,
      var decoration = false,
      var under = false,
      fontWeight}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered
        ? TextAlign.center
        : isEnd
        ? TextAlign.end
        : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    softWrap: true,
    overflow: overFlow ? TextOverflow.ellipsis : TextOverflow.clip,
    style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily,
        fontSize: double.parse(fontSize.toString()),
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration: decoration
            ? TextDecoration.lineThrough
            : under
            ? TextDecoration.underline
            : TextDecoration.none),
  );
}

BoxDecoration boxDecoration(
    {double radius = spacing_middle,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [
            BoxShadow(
                color: MyColorName.colorView.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1)
          ]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

changeStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color, // navigation bar color
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark // status bar color
      ));
}

BoxDecoration boxDecoration2(
    {double radius = spacing_middle,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [
            BoxShadow(
                color: MyColorName.colorView, blurRadius: 6, spreadRadius: 2)
          ]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)),
  );
}

class MyButton extends StatefulWidget {
  var textContent;
  bool selected=false;
  //   var icon;
  VoidCallback onPressed;
  double? width = 80.w;
  double? height = 6.5.h;
  MyButton( {
    @required this.textContent,
    required this.onPressed,
    required this.selected,
    this.width,
    this.height,
    //   @required this.icon,
  });

  @override
  MyButtonState createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
          width: !widget.selected?widget.width:15.w,
          height: widget.height,
          duration: Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          decoration: BoxDecoration(
            boxShadow:  [BoxShadow(color: MyColorName.colorView.withOpacity(0.15), blurRadius: 1, spreadRadius: 1)],
            gradient: new LinearGradient(
              colors: [
                !widget.selected?MyColorName.primaryDark:Colors.white,
                !widget.selected?MyColorName.primaryLite:Colors.white,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              /*  begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),*/
              stops: [0.0, 1.0],),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),

          ),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: !widget.selected?Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: text(widget.textContent, textColor: Colors.white, fontFamily: fontMedium, textAllCaps: false,fontSize: 14.sp),
              ),
            ],
          ):CircularProgressIndicator(color: MyColorName.primaryLite,)),
    );
  }
}

Widget commonImage(url, height, width, placeHolder, context, errorImage) {
  return CachedNetworkImage(
    imageUrl: url,
    height: getHeight(height),
    width: getWidth(width),
    fit: BoxFit.fill,
    placeholder: (context, url) {
      return Container(
        height: getHeight(height),
        width: getWidth(width),
        child: Center(
          child: CircularProgressIndicator(
            color: MyColorName.primaryLite,
          ),
        ),
      );
    },
    errorWidget: (context, url, error) {
      return Image.asset(
        errorImage,
        fit: BoxFit.fill,
        height: getHeight(height),
        width: getWidth(width),
      );
    },
  );
}
Widget commonImage1(url, height, width, placeHolder, context, errorImage) {
  return CachedNetworkImage(
    imageUrl: url,
    height: getWidth(height),
    width: getWidth(width),
    fit: BoxFit.fill,
    placeholder: (context, url) {
      return Container(
        height: getHeight(height),
        width: getWidth(width),
        child: Center(
          child: CircularProgressIndicator(
            color: MyColorName.primaryLite,
          ),
        ),
      );
    },
    errorWidget: (context, url, error) {
      return Image.asset(
        errorImage,
        fit: BoxFit.fill,
        height: getHeight(height),
        width: getWidth(width),
      );
    },
  );
}