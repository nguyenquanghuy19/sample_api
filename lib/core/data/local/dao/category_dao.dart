import 'package:testproject/core/data/local/app_database.dart';
import 'package:testproject/core/data/local/dao/base_dao.dart';
import 'package:testproject/core/data/local/tables/category_table.dart';
import 'package:testproject/core/utils/log_utils.dart';

class CategoryDao extends BaseDao<CategoryTable> {
  static CategoryDao? _instance;

  CategoryDao._();

  factory CategoryDao() => _instance ??= CategoryDao._();

  void init() {
    LogUtils.d("【$runtimeType】init ...");
    db = AppDatabase().database!;
  }

  Future<int> insert(
  {required String id,
    required String name,
      int selected = 0,}
  ) async {
    final bikeImagesTable = CategoryTable.fromParam(id: id, name: name, selected: selected);
    LogUtils.d("【$runtimeType】insert [params:$bikeImagesTable]");
    final item =
        await db.insert(CategoryTable.tableName, bikeImagesTable.toJson());

    return item;
  }

  Future<CategoryTable?> getCategories() async {
    List<CategoryTable> list = [];
    List<Map> maps = await db.query(CategoryTable.tableName, columns: [
      CategoryTable.columnId,
      CategoryTable.columnName,
      CategoryTable.columnSelected,
    ]);

    LogUtils.d("【$runtimeType】getBikeImages [value: $maps]");
    if (maps.isNotEmpty) {
      list = CategoryTable.fromJsonList(maps);

      return list.first;
    }

    return null;
  }

  Future<int> delete(String id) async {
    LogUtils.d("【$runtimeType】delete [userId: $id]");

    return await db.delete(
      CategoryTable.tableName,
      where: '${CategoryTable.columnId} = ?',
      whereArgs: [id],
    );
  }
}
