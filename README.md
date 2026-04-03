# Aun Notifications Logger

A production-grade Flutter package designed to securely log, persist, and display push notification data received locally on a device. It features an adaptive UI precisely mirroring `aun_api_logger` and stores notification logs (title, body, payload data, and routing metadata) in SQLite.

## Features

- **Local Storage**: Automatically persists pushes to local SQLite.
- **Adaptive UI**: High-quality log viewers identical to `aun_api_logger`.
- **Easy Sharing**: Screen capture sharing capability to easily export logs to devs.
- **Routing Data**: Captures `type`, `action`, and `route` directly from Firebase payloads.

## Dependency

```yaml
dependencies:
  aun_notifications_logger:
    git:
      url: https://github.com/maulik1626/aun_notifications_logger.git
      ref: 1.0.0
```

## How to setup

Initialize it when your app boosts (e.g. `main.dart`):
```dart
await AunNotificationsLogger.instance.initialize();
```

Log your notification inside your FirebaseMessaging handler:
```dart
AunNotificationsLogger.instance.logNotification(
  NotificationLogModel(
    title: message.notification?.title ?? '',
    body: message.notification?.body ?? '',
    payload: jsonEncode(message.data),
    type: message.data['type'],
    action: message.data['action'],
    route: message.data['route'],
    timestamp: message.sentTime?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
  )
);
```

Access the UI screens by routing to `NotificationsLogDatesScreen()` or simply placing it in a debug menu.
