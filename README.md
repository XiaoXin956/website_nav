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

