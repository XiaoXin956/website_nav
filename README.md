# website_nav

网站导航

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

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

