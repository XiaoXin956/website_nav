import 'package:flutter/material.dart';

// 圆形icon
Widget circleIcon({double width = 10, double height = 10, Color color = Colors.grey}) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey
    ),
  );
}