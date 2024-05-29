class ResultBean {
  int? code;
  String? msg;
  dynamic data;

  ResultBean({this.code, this.msg, this.data});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['code'] = code;
    if (msg != null) dataMap['msg'] = msg;
    if (data != null) dataMap['data'] = data;
    return dataMap;
  }

}
