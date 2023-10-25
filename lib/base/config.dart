import 'package:website_nav/bean/language_bean.dart';
import 'package:website_nav/bean/user_bean.dart';

class Config{

  static const String baseUrl = "http://192.168.1.140:8080";

  // 语言选项
  static final List<LanguageBean> languageData=[
    LanguageBean(languageCode: "zh",languageName: "中文"),
    LanguageBean(languageCode: "en",languageName: "English"),
  ];

  static UserBean? localUserData;

}