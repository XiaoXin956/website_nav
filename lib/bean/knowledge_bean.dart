import 'package:website_nav/bean/type_bean.dart';

class KnowResult {
  TypeLabelBean? typeParent;

  List<ChildData>? childData;

  KnowResult({this.typeParent, this.childData});

  KnowResult.fromJson(Map<String, dynamic> json) {
    typeParent = json['type_parent'] != null ? new TypeLabelBean.fromJson(json['type_parent']) : null;
    if (json['child_data'] != null) {
      childData = <ChildData>[];
      json['child_data'].forEach((v) {
        childData!.add(new ChildData.fromJson(v));
      });
    }
  }
}

class ChildData {
  TypeLabelBean? typeChild;
  List<KnowledgeBean>? result;
  ChildData({this.typeChild, this.result});
  ChildData.fromJson(Map<String, dynamic> json) {
    typeChild = json['type_child'] != null ? new TypeLabelBean.fromJson(json['type_child']) : null;
    if (json['result'] != null) {
      result = <KnowledgeBean>[];
      json['result'].forEach((v) {
        result!.add(new KnowledgeBean.fromJson(v));
      });
    }
  }
}

class KnowledgeBean {
  int? id;
  int? type_parent_id;
  int? type_child_id;
  String? label;
  String? title;
  String? url;
  String? imgUrl;
  int? typeId;
  String? info;

  KnowledgeBean({this.id,this.type_parent_id,this.type_child_id, this.label, this.title, this.url, this.typeId, this.imgUrl, this.info});

  KnowledgeBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type_parent_id = json['type_parent_id'];
    type_child_id = json['type_child_id'];
    label = json['label'];
    title = json['title'];
    url = json['url'];
    typeId = json['type_id'];
    imgUrl = json['img_url'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_parent_id'] = this.type_parent_id;
    data['type_child_id'] = this.type_child_id;
    data['label'] = this.label;
    data['title'] = this.title;
    data['url'] = this.url;
    data['type_id'] = this.typeId;
    data['img_url'] = this.imgUrl;
    data['info'] = this.info;
    return data;
  }
}
