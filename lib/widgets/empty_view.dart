
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website_nav/widgets/custom_widget.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.w,
            height: 180.h,
            child: Image.asset("lib/assets/images/empty_data.png",),
          ),
          textWidget(text: "搜索结果为空",textStyle: TextStyle(fontSize: 18,color: Colors.white)),
          h(10),
          textWidget(text: "请您查看其他分类",textStyle: TextStyle(fontSize: 14,color: Colors.grey))

        ],
      ),
    );
  }
}
