import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class Clip {
  String filename;
  Clip({this.filename});

  Map<String, dynamic> toMap() {
    return {
      'filename': filename,
    };
  }
}

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    // lazily instantiate the db the first time it is accessed
    _database = await openDatabase(
      join(await getDatabasesPath(), "saved_clips.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE clips(filename TEXT PRIMARY KEY)",
        );
      },
      version: 1,
    );
    return _database;
  }
}