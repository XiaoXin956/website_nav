

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customTextField({
  String label = "",
  String hintText = "",
  String content = "",
  TextStyle? textStyle,
  TextStyle? hintStyle,
  bool enable = true,
  bool obscureText = false,
  FocusNode? focusNode,
  EdgeInsets margin = EdgeInsets.zero,
  TextEditingController? controller,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  Function(String)? onChanged,
  Function(TextEditingController)? onController
}){
  textStyle??const TextStyle(fontSize: 18);
  hintStyle??const TextStyle(fontSize: 18);
  if(content!=""){
    controller!.text = content;
  }

  return Container(
    margin: margin,
    padding: const EdgeInsets.only(left: 10,right: 10),
    decoration:  BoxDecoration(
      border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),),
    child: Row(
      children: [
        (label!="")?
        Expanded(
            flex: 1,
            child: Text(
              label,
              style: textStyle,
            )):Container(),
        Expanded(
            flex: 5,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                if(onChanged==null){
                  return;
                }
                onChanged(value);
              },
              focusNode: focusNode,
              enabled: enable,
              obscureText: obscureText,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: hintText,
                hintStyle: hintStyle,
                isCollapsed: true,
                contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              style: textStyle,
            )),
      ],
    ),
  );
}