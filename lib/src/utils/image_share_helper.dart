import 'dart:io';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

/// Writes a PNG screenshot to a temp file with a descriptive name for sharing.
class ImageShareHelper {
  static Future<File> writeSharePngFile({
    required Uint8List pngBytes,
    required String type,
    required String displayRoute,
    required int timestamp,
  }) async {
    final timeStr = DateFormat(
      'hh-mm-ss_a',
    ).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    final routeSlug = displayRoute
        .replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    final fileName = '${type}_${routeSlug}_$timeStr.png';

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(pngBytes);
    return file;
  }
}
