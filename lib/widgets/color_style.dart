import 'dart:ui';

import 'package:flutter/material.dart';

Color color31BC58 = const Color(0xff31BC58);
Color color01B075 = const Color(0xff01B075);
Color colorE0E0E0 = const Color(0xffE0E0E0);

// 明亮
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  buttonTheme: ButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
);

// 黑暗
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
);
