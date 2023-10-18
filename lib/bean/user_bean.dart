class UserBean {
  int? id;
  String? name;
  String? loginType;
  String? password;

  UserBean({this.id, this.name, this.loginType, this.password});

  UserBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    loginType = json['login_type'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['login_type'] = this.loginType;
    data['password'] = this.password;
    return data;
  }
}
