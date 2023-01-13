import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testproject/core/data/local/tables/category_table.dart';
import 'package:testproject/core/utils/log_utils.dart';

class AppDatabase {
  static const String databaseName = "bassist.db";
  static const int databaseVersion = 1;
  Database? _database;

  Database? get database => _database;

  static AppDatabase? _instance;

  /// Constructor
  AppDatabase._();

  factory AppDatabase() {
    return _instance ??= AppDatabase._();
  }

  Future<Database?> onInit() async {
    LogUtils.d("【$runtimeType】【Database】 init ...");
    if (_database == null) {
      var databasesPath = await getDatabasesPath();
      var path = join(databasesPath, databaseName);
      _database = await openDatabase(
        path,
        version: databaseVersion,
        onCreate: (db, version) async {
          await db.execute(CategoryTable.create());
        },
      );
    }

    return _database;
  }
}
