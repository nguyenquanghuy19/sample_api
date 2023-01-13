class CategoryTable {
  static const String tableName = 'categories';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnSelected = 'selected'; // true : 1, false : 0

  String? id;
  String? name;
  int? selected;

  Map<String, dynamic> toJson() => <String, dynamic>{
        columnId: id,
        columnName: name,
        columnSelected: selected,
      };

  static List<CategoryTable> fromJsonList(List<Map> json) {
    List<CategoryTable> list = [];
    for (Map obj in json) {
      list.add(CategoryTable.fromJson(obj as Map<String, dynamic>));
    }

    return list;
  }

  CategoryTable.fromJson(Map<String, dynamic> json) {
    id = json[columnId] as String;
    name = json[columnName] as String;
    selected = json[columnSelected] as int;
  }

  CategoryTable.fromParam({
    this.id,
    this.name,
    this.selected,
  });

  static String create() {
    return "CREATE TABLE $tableName ("
        "$columnId INTEGER NOT NULL UNIQUE,"
        "$columnName TEXT, "
        "$columnSelected INTEGER NOT NULL DEFAULT 0, "
        ")";
  }
}
