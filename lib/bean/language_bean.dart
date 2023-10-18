
class LanguageBean {
  String? languageCode;
  String? languageName;

  LanguageBean({this.languageCode, this.languageName});

  LanguageBean.fromJson(Map<String, dynamic> json) {
    languageCode = json['language_code'];
    languageName = json['language_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_code'] = this.languageCode;
    data['language_name'] = this.languageName;
    return data;
  }
}
