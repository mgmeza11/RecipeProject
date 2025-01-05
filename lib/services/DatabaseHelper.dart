import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), DATABASE_NAME);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $RECIPES_TABLENAME (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, image_path TEXT, category_code TEXT);');
    await db.execute('CREATE TABLE $STEPS_TABLENAME (id INTEGER PRIMARY KEY AUTOINCREMENT, id_recipe INTEGER, description TEXT, order_step INTEGER);');
    await db.execute('CREATE TABLE $TAGS_TABLENAME (id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT);');
    await db.execute('CREATE TABLE $TAG_RECIPE_TABLENAME (id INTEGER PRIMARY KEY AUTOINCREMENT, id_recipe INTEGER, id_tag INTEGER);');
    await db.execute('CREATE TABLE $INGREDIENTS_TABLENAME (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, id_recipe INTEGER, count TEXT, unit TEXT);');
  }

  Future<int> add(String tableName, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> addList(String tableName, List<Map<String, dynamic>> dataList) async {
    for (var data in dataList){
      add(tableName, data);
    }
  }

  Future<void> update(String tableName, Map<String, dynamic> data) async {
    var id = data['id'];
    final db = await database;
    await db.update(
      tableName,
      data,
      where: "id = ?",
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateWhere(String tableName, Map<String, dynamic> data, String where, List<Object> whereArgs) async {
    final db = await database;
    await db.update(
      tableName,
      data,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<void> delete(String tableName, int id) async{
    await deleteWhere(tableName, 'id = ? ', [id]);
  }

  Future<void> deleteWhere(String tableName, String where, List<Object> whereArgs ) async{
    final db = await database;
    await db.delete(tableName, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    final db = await database;
    return await db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> getWhere(String tableName, String where, List<dynamic> whereArgs ) async {
    final db = await database;
    return await db.query(tableName, where: where, whereArgs: whereArgs);
  }

  Future<Map<String, dynamic>?> findById(String tableName, int id) async {
    List<Map<String, dynamic>> results = await getWhere(tableName, 'id = ? ', [id]);
    return results.first;
  }

  Future<List<Map<String, Object?>>> queryById(String query, int arguments) async {
    final db = await database;
    return await db.rawQuery(query, [arguments]);
  }

  Future<List<Map<String, Object?>>> query(String query, List<dynamic> arguments) async {
    final db = await database;
    return await db.rawQuery(query, arguments);
  }

}

final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper();
});