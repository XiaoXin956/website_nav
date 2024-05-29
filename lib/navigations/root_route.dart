
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'dart:html'  as html;


class RootRouter{

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 单例
  factory RootRouter() => _sharedInstance();

  static RootRouter? _instance;

  RootRouter._internal();

  static RootRouter _sharedInstance(){
    _instance ??= RootRouter._internal();
    return _instance!;
  }

  Map<String,WidgetBuilder> routes={};
  RouteFactory get generateRoute => (settings) {
    return null;
  };

  void initRoute(List<Map<String,WidgetBuilder>> routeLost){
    routes.clear();
    for (var element in routeLost) {
      routes.addAll(element);
    }
    printBlue("初始化完成");
  }

  void pushName({String name="",Object? arguments}){
    RootRouter().navigatorKey.currentState?.pushNamed(name,arguments: arguments);
    printBlue("返回 ${arguments.toString()}");
  }

  void pushNamedAndRemoveUntil({String name="",Object? arguments}){
    RootRouter().navigatorKey.currentState?.pushNamedAndRemoveUntil(name, (route) => false);
    printBlue("返回 ${arguments.toString()}");
  }

  void pop([Object? result]){
    RootRouter().navigatorKey.currentState?.pop(result);
    printBlue("返回 ${result.toString()}");
  }

  void pushUrl({String url=""}){
    // 跳转
    if(kIsWeb){
      // String url = "http://${html.window.location.host}/feedback";
      html.window.open("http://${html.window.location.host}/$url","_blank");
    }else{

    }
  }

  printBlue(dynamic msg){
    if (kDebugMode) {
      print("\x1B[34m ${msg} \x1B[0m");
    }
  }

}