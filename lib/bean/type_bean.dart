class TypeBean {
  int id;
  String name;

  TypeBean({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
        "id": "$id",
        "name": "$name",
      };

  TypeBean toFrom(Map<String, dynamic> maps) => TypeBean(id: maps['id'], name: maps['name']);

}
