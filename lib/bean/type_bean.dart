class TypeBean {
  int id;
  String name;
  List<TypeBean?>? childTypeData = [];

  TypeBean({required this.id, required this.name, this.childTypeData});

  factory TypeBean.fromJson(Map<String, dynamic> maps) => TypeBean(
        id: maps['id'],
        name: maps['name'],
        childTypeData: (maps["childBean"] as List<dynamic>).map((e){
          return TypeBean.fromJson(e);
        }).toList(),
      );
}
