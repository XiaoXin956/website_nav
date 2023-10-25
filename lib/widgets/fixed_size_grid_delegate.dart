import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/src/rendering/sliver_grid.dart';

/// gridview item distance fixed height
class FixedSizeGridDelegate extends SliverGridDelegate {
  final double width;
  final double height;
  final double mainAxisSpacing;
  final double minCrossAxisSpacing;

  FixedSizeGridDelegate(
    this.width,
    this.height, {
    this.mainAxisSpacing = 0.0,
    this.minCrossAxisSpacing = 0.0,
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    int crossAxisCount = constraints.crossAxisExtent ~/ width;
    double crossAxisSpacing = (constraints.crossAxisExtent - width * crossAxisCount) / (crossAxisCount - 1);
    while (crossAxisSpacing < minCrossAxisSpacing) {
      crossAxisCount -= 1;
      crossAxisSpacing = (constraints.crossAxisExtent - width * crossAxisCount) / (crossAxisCount - 1);
    }
    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: height + mainAxisSpacing,
      crossAxisStride: width + crossAxisSpacing,
      childMainAxisExtent: height,
      childCrossAxisExtent: width,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(FixedSizeGridDelegate oldDelegate) {
    return oldDelegate.width != width || oldDelegate.height != height || oldDelegate.mainAxisSpacing != mainAxisSpacing;
  }
}
