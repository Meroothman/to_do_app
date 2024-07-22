import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? dbdb;

  Future<Database?> get db async {
    if (dbdb == null) {
      dbdb = await intialDb();
      return dbdb;
    } else {
      return dbdb;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'sqflite.db');
    Database mydb = await openDatabase(path, onCreate: onCreate, version: 2);
    return mydb;
  }

  onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "title" TEXT NOT NULL, 
      "note" TEXT NOT NULL)
    ''');
    //print("creat Database And Tables");
  }

  // select data
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  // insert data
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  // update data
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  // delete data
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  //delete database
  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'sqflite.db');
    await deleteDatabase(path);
  }
}
