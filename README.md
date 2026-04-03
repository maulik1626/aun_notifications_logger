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
      ref: 1.0.3
```

## How to setup

Initialize it when your app boosts (e.g. `main.dart`):
```dart
await AunNotificationsLogger.instance.initialize();
```

### When is a notification stored?
This package only writes a log entry when you call:
`AunNotificationsLogger.instance.logNotification(...)`.

So whether a notification appears in the log on:
- **arrival** (message received), or
- **tap/open** (user opens the notification)

depends entirely on which Firebase callback/handler you invoke `logNotification()` from.

### Log on arrival (message received)
Call `logNotification()` from the handler that runs when the message is received:
```dart
// Example (foreground):
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  AunNotificationsLogger.instance.logNotification(
    NotificationLogModel(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      payload: jsonEncode(message.data),
      type: message.data['type'],
      action: message.data['action'],
      route: message.data['route'],
      timestamp: message.sentTime?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
    ),
  );
});
```

### Log on tap/open (notification opened)
Call `logNotification()` from the handler that runs when the user taps the notification:
```dart
// Example:
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  AunNotificationsLogger.instance.logNotification(
    NotificationLogModel(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      payload: jsonEncode(message.data),
      type: message.data['type'],
      action: message.data['action'],
      route: message.data['route'],
      timestamp: message.sentTime?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
    ),
  );
});
```

### Cold start (tap when app was not running)
If you need to log a tap that launches the app from a terminated state, invoke `logNotification()` from whatever code path you use with `FirebaseMessaging.getInitialMessage()`.

Access the UI screens by routing to `NotificationsLogDatesScreen()` or simply placing it in a debug menu.
