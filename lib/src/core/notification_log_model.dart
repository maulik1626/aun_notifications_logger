class NotificationLogModel {
  int? id;
  final String? title;
  final String? body;
  final String? payload;
  final String? type;
  final String? action;
  final String? route;
  final int timestamp; // stored in epoch milliseconds

  NotificationLogModel({
    this.id,
    this.title,
    this.body,
    this.payload,
    this.type,
    this.action,
    this.route,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
      'type': type,
      'action': action,
      'route': route,
      'timestamp': timestamp,
    };
  }

  factory NotificationLogModel.fromMap(Map<String, dynamic> map) {
    return NotificationLogModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      payload: map['payload'],
      type: map['type'],
      action: map['action'],
      route: map['route'],
      timestamp: map['timestamp'] ?? 0,
    );
  }
}
