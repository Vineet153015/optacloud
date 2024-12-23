import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteService {
  static final SQLiteService _instance = SQLiteService._internal();
  factory SQLiteService() => _instance;

  Database? _database;

  SQLiteService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'health_data.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE health_records (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            heartRate INTEGER NOT NULL,
            steps INTEGER NOT NULL,
            timestamp TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertRecord(int heartRate, int steps, String timestamp) async {
    final db = await database;
    return await db.insert('health_records', {
      'heartRate': heartRate,
      'steps': steps,
      'timestamp': timestamp,
    });
  }

  Future<List<Map<String, dynamic>>> getAllRecords() async {
    final db = await database;
    return await db.query('health_records', orderBy: "timestamp DESC");
  }
}
