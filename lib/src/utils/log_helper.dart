class LogHelper {
  static String getPayloadType(String? payload) {
    if (payload == null || payload.isEmpty) return '';
    try {
      if (payload.trim().startsWith('{')) {
        return ' (JSON)';
      } else if (payload.trim().startsWith('<')) {
        return ' (XML)';
      }
    } catch (_) {}
    return '';
  }
}
