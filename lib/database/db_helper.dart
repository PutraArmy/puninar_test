import 'package:path_provider/path_provider.dart';
import 'package:puninar_absen_test/models/absensi_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<void> createTabel(sql.Database database) async {
    await database.execute("""
    CREATE TABLE absensi(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      tanggal TEXT,
      jam TEXT,
      lat TEXT,
      long TEXT,
      photo TEXT,
      type TEXT
    )
    """);
  }

  // create database
  static Future<sql.Database> db() async {
    return sql.openDatabase('absensi.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTabel(database);
    });
  }

  //add data to table
  static Future<int> tambahAbsensi(Absensi absensi) async {
    final db = await DBHelper.db();
    final data = absensi.toJson();
    return await db.insert('absensi', data);
  }

  //get data from database
  static Future<List<Map<String, dynamic>>> getAbsensi() async {
    final db = await DBHelper.db();
    return db.query('absensi');
  }
}
