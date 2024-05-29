
class KnowledgeBean {
  int? id;
  String? label;
  String? title;
  String? url;
  String? imgUrl;
  int? typeId;
  String? describe;

  KnowledgeBean({this.id, this.label, this.title, this.url, this.typeId, this.imgUrl, this.describe});

  KnowledgeBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    title = json['text'];
    url = json['url'];
    typeId = json['type_id'];
    imgUrl = json['img_url'];
    describe = json['describe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['text'] = this.title;
    data['url'] = this.url;
    data['type_id'] = this.typeId;
    data['img_url'] = this.imgUrl;
    data['describe'] = this.describe;
    return data;
  }

}
