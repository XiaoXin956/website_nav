
class KnowledgeBean {
  int? id;
  String? label;
  String? text;
  String? url;
  String? imgUrl;
  int? typeId;

  KnowledgeBean({this.id, this.label, this.text, this.url, this.typeId, this.imgUrl});

  KnowledgeBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    text = json['text'];
    url = json['url'];
    typeId = json['type_id'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['text'] = this.text;
    data['url'] = this.url;
    data['type_id'] = this.typeId;
    data['img_url'] = this.imgUrl;
    return data;
  }

}
