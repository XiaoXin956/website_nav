import 'package:flutter/material.dart';

/// 文本样式
TextStyle setStyle({double fontSize = 16, Color color = Colors.black, FontWeight fontWeight = FontWeight.normal}) {
  TextStyle textStyle = TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  return textStyle;
}

/// 按钮样式
ButtonStyle setButtonStyle({
  TextStyle? textStyle,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? shadowColor,
  Color? surfaceTintColor,
}) {

  return ButtonStyle(
    textStyle: MaterialStatePropertyAll(textStyle),
    backgroundColor: MaterialStatePropertyAll(backgroundColor),
    foregroundColor: MaterialStatePropertyAll(foregroundColor),
    shadowColor: MaterialStatePropertyAll(shadowColor),
    surfaceTintColor: MaterialStatePropertyAll(surfaceTintColor),
  );
}
