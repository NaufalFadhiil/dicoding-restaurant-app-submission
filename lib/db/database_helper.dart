import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data/models/restaurant.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorites';

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'restaurant.db');

    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $_tblFavorite (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL
        )
      ''');
      },
      version: 1,
    );
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(
      _tblFavorite,
      restaurant.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(_tblFavorite, where: 'id = ?', whereArgs: [id]);
  }

  Future<Restaurant?> getFavoriteById(String id) async {
    final db = await database;
    final results = await db.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return Restaurant.fromJson(results.first);
    }
    return null;
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    final results = await db.query(_tblFavorite);
    return results.map((e) => Restaurant.fromJson(e)).toList();
  }
}
