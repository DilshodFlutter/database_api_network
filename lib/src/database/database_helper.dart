import 'dart:async';

import 'package:database_api_network/src/model/net_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelperNew {
  static final DatabaseHelperNew _instance = DatabaseHelperNew.internal();

  factory DatabaseHelperNew() => _instance;

  final String tableName = 'sdcsTable';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnFullName = 'slug';
  final String columnSlug = 'full_name';
  final String columnImage = 'image';
  final String columnPrice = 'price';
  final String columnDrugId = 'drug_id';

  static Database? _db;

  DatabaseHelperNew.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();

    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'zdcds.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$columnId INTEGER PRIMARY KEY, '
      '$columnName TEXT, '
      '$columnSlug TEXT, '
      '$columnImage TEXT, '
      '$columnPrice REAL, '
      '$columnDrugId INTEGER, '
      '$columnFullName TEXT)',
    );
  }

  Future<int> saveData(NetModel item) async {
    var dbClient = await db;
    var result = await dbClient.insert(
      tableName,
      item.toJson(),
    );
    return result;
  }

  Future<List<NetModel>> getData() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableName');
    List<NetModel> products = <NetModel>[];
    for (int i = 0; i < list.length; i++) {
      NetModel items = NetModel(
        id: list[i][columnId],
        name: list[i][columnName],
        fullName: list[i][columnFullName],
        image: list[i][columnImage],
        slug: list[i][columnSlug],
        price: list[i][columnPrice],
        drugId: list[i][columnDrugId],
      );
      products.add(items);
    }
    return products;
  }

  Future<int> deleteData(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateData(NetModel products) async {
    var dbClient = await db;
    return await dbClient.update(
      tableName,
      products.toJson(),
      where: "$columnId = ?",
      whereArgs: [products.id],
    );
  }
}
