import 'package:sqflite/sqflite.dart';

/// BaseDao
abstract class BaseDao<T> {
  late final Database db;
}
