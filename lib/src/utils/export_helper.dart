import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../core/notification_log_model.dart';
import '../storage/local_storage_service.dart';

class ExportHelper {
  /// Exports all logs of a day to a JSON file and opens the share dialog.
  static Future<void> exportAndShareLogs(
    List<NotificationLogModel> logs,
    String dateStr,
  ) async {
    if (logs.isEmpty) return;

    final List<Map<String, dynamic>> jsonList = logs
        .map((l) => l.toMap())
        .toList();
    final String jsonString = const JsonEncoder.withIndent(
      '  ',
    ).convert(jsonList);

    final directory = await getTemporaryDirectory();
    final File file = File('${directory.path}/notification_logs_$dateStr.json');
    await file.writeAsString(jsonString);

    // ignore: deprecated_member_use
    await Share.shareXFiles([
      XFile(file.path),
    ], text: 'Notification Logs for $dateStr');
  }

  /// Exports the entire database
  static Future<void> exportAllLogs() async {
    final logs = await LocalStorageService.instance.getAllLogs();
    await exportAndShareLogs(logs, 'all_history');
  }
}
