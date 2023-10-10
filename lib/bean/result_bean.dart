class ResultBean {
  int? code;
  String? msg;
  dynamic data;

  ResultBean({this.code, this.msg, this.data});

  Map<String, dynamic> toJson() => {
        "code": "$code",
        "msg": "$msg",
        "data": "$data",
      };
}
