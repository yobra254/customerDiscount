import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
CREATE TABLE discount(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  vehicle TEXT,
  number TEXT,
  product TEXT,
  volume TEXT,
  unitrate TEXT,
  total TEXT,
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_name.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createData(
    String vehicle,
    String number,
    String product,
    String volume,
    String? unitrate,
    String total,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'vehicle': vehicle,
      'number': number,
      'product': product,
      'volume': volume,
      'unitrate': unitrate,
      'total': total,
    };
    final id = await db.insert('discount', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('discount', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('discount', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(int id, String vehicle, String number,
      String product, String volume, String? unitrate, String total) async {
    final db = await SQLHelper.db();
    final data = {
      'vehicle': vehicle,
      'number': number,
      'product': product,
      'volume': volume,
      'unitrate': unitrate,
      'total': total,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('discount', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('discount', where: "id = ?", whereArgs: [id]);
    } catch (e) {}
  }
}
