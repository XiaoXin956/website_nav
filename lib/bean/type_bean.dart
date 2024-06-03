class TypeLabelBean {
  int? id;
  int? parentId;
  String? name;
  List<TypeLabelBean>? parent=[];

  TypeLabelBean({this.id, this.parentId, this.name, this.parent});


  TypeLabelBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    if (json['parent'] != null) {
      parent = <TypeLabelBean>[];
      json['parent'].forEach((v) {
        parent!.add(TypeLabelBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (parentId != null) data['parent_id'] = parentId;
    if (name != null) data['name'] = name;
    if (parent != null) data['parent'] = parent;
    return data;
  }



}
