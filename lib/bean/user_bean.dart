class UserBean {
  int? id;
  String? userName;
  String? userEmail;
  int? userType;
  String? password;
  String? updateTime;
  String? createTime;

  UserBean({this.id, this.userName, this.userEmail, this.userType, this.password, this.updateTime, this.createTime});

  UserBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userType = json['user_type'];
    password = json['password'];
    updateTime = json['update_time'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (userName != null) data['user_name'] = userName;
    if (userEmail != null) data['user_email'] = userEmail;
    if (password != null) data['user_type'] = userType;
    if (password != null) data['password'] = password;
    if (updateTime != null) data['update_time'] = updateTime;
    if (createTime != null) data['create_time'] = createTime;
    return data;
  }
}
