import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/dog.dart';

class DBService {
  static Database? _database;
  static const String tableName = "dogs";

  // ✅ Ensure database is initialized before use
  static Future<Database> get database async {
    if (_database == null) {
      _database = await _initDB();
    }
    return _database!;
  }

  // ✅ Initialize database
  static Future<Database> _initDB() async {
    try {
      print("Initializing database...");
      String path = join(await getDatabasesPath(), 'dogs.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          print("Creating database table...");
          await db.execute('''
            CREATE TABLE $tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              breed TEXT,
              image TEXT,
              description TEXT
            )
          ''');
          print("Database table created successfully.");
        },
      );
    } catch (e) {
      print("Error initializing database: $e");
      rethrow;
    }
  }

  // ✅ Save a dog to the database
  static Future<void> insertDog(Dog dog) async {
    final db = await database;
    try {
      print("Inserting dog: ${dog.name}");
      await db.insert(
        tableName,
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Dog inserted successfully.");
    } catch (e) {
      print("Error inserting dog: $e");
    }
  }

  // ✅ Fetch all saved dogs
  static Future<List<Dog>> getSavedDogs() async {
    final db = await database;
    try {
      print("Fetching saved dogs from database...");
      final List<Map<String, dynamic>> maps = await db.query(tableName);
      print("Fetched ${maps.length} saved dogs.");
      return List.generate(maps.length, (i) {
        return Dog.fromMap(maps[i]);
      });
    } catch (e) {
      print("Error fetching dogs: $e");
      return [];
    }
  }

  // ✅ Delete a saved dog
  static Future<void> deleteDog(int id) async {
    final db = await database;
    try {
      print("Deleting dog with ID: $id");
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
      print("Dog deleted successfully.");
    } catch (e) {
      print("Error deleting dog: $e");
    }
  }
}
