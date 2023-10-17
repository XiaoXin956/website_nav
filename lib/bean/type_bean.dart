class TypeBean {
  int? id;
  String? name;
  int? parentId;
  List<TypeBean?>? childTypeData = [];

  TypeBean({required this.id, required this.name,required this.parentId, this.childTypeData});

  factory TypeBean.fromJson(Map<String, dynamic> maps) => TypeBean(
        id: maps['id'],
        name: maps['name'],
    parentId: maps['parentId']??maps['parentId'],
        childTypeData: (maps["childBean"]!=null)? (maps["childBean"] as List<dynamic>).map((e){
          return TypeBean.fromJson(e);
        }).toList():null,
      );
}
