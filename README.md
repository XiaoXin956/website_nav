客户端运行调试的时候会出现跨域的问题
- 方法1 ![img.png](img/run_args.png)
- 内容是--web-renderer html --web-browser-flag=--disable-web-security

- 方法2
- 转到 flutter\bin\cache并删除名为：flutter_tools.stamp
- 转到 flutter\packages\flutter_tools\lib\src\web并打开文件chrome.dart。
- 查找 '--disable-extensions'
- 下方添加'--disable-web-security'

知识点

修改浏览器标签标题
```dart
SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: '${S.of(context).knowledge}',
      ),
    );
```

web 超链接跳转
在 MaterailApp 中使用 onGenerateRoute

```dart
import 'dart:html' as html;
// 在跳转的页面中使用
window.location.href = "http://${html.window.location.host}/feedback?name=123&age=12"
// MaterialApp
onGenerateRoute: (settings) {
                String urlName = settings.name.toString();
                if (urlName == '/') {
                  //首页
                  return MaterialPageRoute(builder: (BuildContext context) {
                    return HomePage();
                  });
                }if(urlName.startsWith("/feedback")){
                  // 解析url
                  final params = settings.name!.substring(settings.name!.lastIndexOf("?")+1,settings.name!.length);
                  Map<String,dynamic> urlAnalyzeData = urlAnalyze(params);
                  dynamic name = urlAnalyzeData["name"];
                  dynamic age = urlAnalyzeData["age"];
                  return MaterialPageRoute(builder: (BuildContext context) {
                       // 参数传递
                    return FeedbackPage();
                  });
                }
                return null;
              },
```