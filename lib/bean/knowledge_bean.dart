
class KnowledgeBean {
  int? id;
  String? label;
  String? text;
  String? url;
  int? typeId;

  KnowledgeBean({this.id, this.label, this.text, this.url, this.typeId});

  KnowledgeBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    text = json['text'];
    url = json['url'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['text'] = this.text;
    data['url'] = this.url;
    data['type_id'] = this.typeId;
    return data;
  }
}
