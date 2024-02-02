class TypeBean {
  int? id;
  String? name;

  TypeBean({required this.id, required this.name});

  factory TypeBean.fromJson(Map<String, dynamic> maps) => TypeBean(
        id: maps['id'],
        name: maps['name'],
      );
}
