import 'package:flutter/material.dart';
import 'package:website_nav/base/config.dart';
import 'package:website_nav/bean/language_bean.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/login/login_view.dart';
import 'package:website_nav/utils/print_utils.dart';
import 'package:website_nav/widgets/triangle_indicator_painter.dart';

// 确认 取消 按钮的弹框
showDialogConfirmCancel({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required Widget leftWidget,
  required Widget rightWidget,
  Function()? left,
  Function()? right,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 14, bottom: 10),
                    child: title,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 14),
                    child: content,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      leftWidget,
                      SizedBox(
                        width: 10,
                      ),
                      rightWidget,
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

// 编辑
showDialogEdit({required BuildContext context, required TypeBean typeBean, Function(String)? submit}) {
  TextEditingController _text = TextEditingController(text: typeBean.name);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 标签名称
                      Text("标签名zh："),
                      Expanded(
                          child: TextField(
                        controller: _text,
                        maxLength: 30,
                        decoration: InputDecoration(),
                      )),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        submit!(_text.value.text);
                      },
                      child: Text("提交")),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

// 语言选择
showLanguageSelect({required BuildContext context, required Rect rect, required Function(LanguageBean) selectLanguage}) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned(
              top: rect.bottom + 40,
              right: rect.left + 10,
              child: Column(
                children: [
                  // 绘制一个三角形
                  CustomPaint(
                    painter: TriangleIndicatorPainter(),
                    child: Container(
                      width: 10,
                      height: 6,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                    width: 100,
                    child: Column(
                      children: Config.languageData.map((e) {
                        return Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              selectLanguage(e);
                            },
                            child: Column(
                              children: [
                                Text("${e.languageName}"),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ))
        ],
      );
    },
  );
}

// 登录
showLogin({required BuildContext context}) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Center(
            child: LoginPage(),
          )
        ],
      );
    },
  );
}

// 类型选择
showTypeSelect({required BuildContext context, required Rect rect, required List<TypeBean> typeData, required Function(TypeBean) selectData}) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Center(
              // top: rect.top,
              // left: rect.left,
              child: Container(
            height: 300,
            width: 200,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.red, width: 1)),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2),
                    itemCount: typeData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            selectData(typeData[index]);
                          },
                          child: Container(child: Text(
                            "${typeData[index].name}",
                            style: TextStyle(fontSize: 15,decoration: TextDecoration.none),
                          ),alignment: Alignment.center,),
                        ),
                      );
                    },
                  ),
                ))
              ],
            ),
          ))
        ],
      );
    },
  );
}
