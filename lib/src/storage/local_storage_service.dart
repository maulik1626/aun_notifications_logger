import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../core/notification_log_model.dart';
import 'package:intl/intl.dart';

class LocalStorageService {
  static final LocalStorageService instance = LocalStorageService._init();
  static Database? _database;

  LocalStorageService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aun_notifications_logger.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const intType = 'INTEGER';

    await db.execute('''
CREATE TABLE notification_logs (
  id $idType,
  title $textType,
  body $textType,
  payload $textType,
  type $textType,
  action $textType,
  route $textType,
  timestamp $intType
)
''');
  }

  Future<int> insertLog(NotificationLogModel log) async {
    final db = await instance.database;
    return await db.insert('notification_logs', log.toMap());
  }

  /// Returns distinct dates in the format YYYY-MM-DD that have logs
  Future<List<String>> getLogDates() async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT DISTINCT timestamp FROM notification_logs ORDER BY timestamp DESC',
    );

    // Convert epoch to formatted dates to group them
    final Set<String> distinctDates = {};
    for (var row in result) {
      final requestTime = row['timestamp'] as int;
      final date = DateTime.fromMillisecondsSinceEpoch(requestTime);
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      distinctDates.add(formattedDate);
    }
    return distinctDates.toList();
  }

  /// Fetches all logs for a specific YYYY-MM-DD date
  Future<List<NotificationLogModel>> getLogsByDate(String dateStr) async {
    final db = await instance.database;

    // Parse the start and end of that day
    final dateTimeStr = '$dateStr 00:00:00.000';
    final startOfDay = DateTime.parse(dateTimeStr).millisecondsSinceEpoch;
    final endOfDay = startOfDay + 86400000; // + 1 day in milliseconds

    final result = await db.rawQuery(
      'SELECT * FROM notification_logs WHERE timestamp >= ? AND timestamp < ? ORDER BY timestamp DESC',
      [startOfDay, endOfDay],
    );

    return result.map((json) => NotificationLogModel.fromMap(json)).toList();
  }

  Future<int> deleteLogsByDate(String dateStr) async {
    final db = await instance.database;
    final dateTimeStr = '$dateStr 00:00:00.000';
    final startOfDay = DateTime.parse(dateTimeStr).millisecondsSinceEpoch;
    final endOfDay = startOfDay + 86400000;

    return await db.delete(
      'notification_logs',
      where: 'timestamp >= ? AND timestamp < ?',
      whereArgs: [startOfDay, endOfDay],
    );
  }

  Future<int> deleteAllLogs() async {
    final db = await instance.database;
    return await db.delete('notification_logs');
  }

  Future<List<NotificationLogModel>> getAllLogs() async {
    final db = await instance.database;
    const orderBy = 'timestamp DESC';
    final result = await db.query('notification_logs', orderBy: orderBy);
    return result.map((json) => NotificationLogModel.fromMap(json)).toList();
  }
}
