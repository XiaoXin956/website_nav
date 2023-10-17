import 'package:flutter/material.dart';
import 'package:website_nav/bean/type_bean.dart';

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
  TextEditingController _text = TextEditingController(text:typeBean.name );

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
