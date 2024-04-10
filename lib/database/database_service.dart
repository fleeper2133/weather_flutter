import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather_flutter/database/city_db.dart';

class DatabaseService{
  Database? _database;

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database = await _initialize();
    print(await getDatabasesPath());
    return _database!;
  }

  Future<String> get fullPath async{
    const name = 'city.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async{
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true
    );
    return database;
  }

  Future<void> create(Database database, int version) async{
    await CityDB().createTable(database);
  }
}