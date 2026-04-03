import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogColorHelper {
  static Color getTypeColor(String? type) {
    final t = type?.toLowerCase() ?? 'push';
    switch (t) {
      case 'alert':
      case 'navigate':
        return const Color(0xFF0D47A1); // Blue
      case 'data':
      case 'silent':
        return const Color(0xFF004D40); // Teal
      case 'promo':
      case 'campaign':
        return const Color(0xFFE65100); // Orange
      case 'error':
        return const Color(0xFFB71C1C); // Red
      default:
        return const Color(0xFF455A64); // Blue Grey
    }
  }

  static Color getStatusColor(dynamic status) {
    // For notifications, we don't have HTTP status codes.
    return const Color(0xFF4CAF50); // Default success green
  }
}
