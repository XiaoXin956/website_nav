
class FeedbackBean {
  int? id;
  String email;
  String name;
  String content;
  String? createTime;

  FeedbackBean({this.id, required this.email, required this.name, required this.content, this.createTime});

  FeedbackBean.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    email = json['email'],
    name = json['name'],
    content = json['content'],
    createTime = json['create_time'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['content'] = this.content;
    data['create_time'] = this.createTime;
    return data;
  }

}