import 'notification_log_model.dart';
import '../storage/local_storage_service.dart';

class AunNotificationsLogger {
  static final AunNotificationsLogger instance = AunNotificationsLogger._init();

  AunNotificationsLogger._init();

  /// Initializes the local SQLite database.
  Future<void> initialize() async {
    await LocalStorageService.instance.database;
  }

  /// Logs a NotificationLogModel into the local database
  Future<void> logNotification(NotificationLogModel log) async {
    await LocalStorageService.instance.insertLog(log);
  }
}
