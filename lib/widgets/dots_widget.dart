import 'package:flutter/material.dart';

import 'color_style.dart';

/// 圆形
class DotsWidget extends StatelessWidget {
  double width = 10;
  double height = 10;
  Color? color = color31BC58;
  BorderRadiusGeometry radius = BorderRadius.circular(10);

  DotsWidget({
    super.key,
    this.width = 10,
    this.height = 10,
    this.color,
    this.radius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color?? color31BC58,
        borderRadius: radius
      ),
    );
  }
}
