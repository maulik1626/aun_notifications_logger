import 'package:flutter_test/flutter_test.dart';

import 'package:aun_notifications_logger/aun_notifications_logger.dart';

void main() {
  test('NotificationLogModel toMap/fromMap round-trip', () {
    const timestamp = 1_711_200_000_000;

    final original = NotificationLogModel(
      id: 42,
      title: 'Title',
      body: 'Body',
      payload: '{"k":"v"}',
      type: 'push',
      action: 'open',
      route: '/home',
      timestamp: timestamp,
    );

    final map = original.toMap();
    final decoded = NotificationLogModel.fromMap(map);

    expect(decoded.id, equals(original.id));
    expect(decoded.title, equals(original.title));
    expect(decoded.body, equals(original.body));
    expect(decoded.payload, equals(original.payload));
    expect(decoded.type, equals(original.type));
    expect(decoded.action, equals(original.action));
    expect(decoded.route, equals(original.route));
    expect(decoded.timestamp, equals(original.timestamp));
  });
}
