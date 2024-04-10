import 'package:sqflite/sqlite_api.dart';
import 'package:weather_flutter/database/database_service.dart';
import 'package:weather_flutter/model/city.dart';

class CityDB{
  final tableName = 'city';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName(
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "value" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create({required String title, String? value}) async{
    value ??= title;
    print(title);
    final database = await DatabaseService().database;
    return await database.rawInsert(
      """INSERT INTO $tableName (title, value) VALUES (?, ?)""",
      [title, value]
      );
  }

  Future<List<City>> fetchAll() async{
    final database = await DatabaseService().database;
    final cities = await database.rawQuery(
      """SELECT * FROM $tableName"""
    );
    return cities.map((city) => City.fromSqliteDatabase(city)).toList();
  }
}