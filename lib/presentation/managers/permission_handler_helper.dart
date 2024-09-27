import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../pages/home_screen/home_screen.dart';
import '../utils/helpers/routes/custom_routes.dart';

class PermissionHandlingHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> requestNotificationPermission(BuildContext context) async {
    // Request notification permission from the system
    await Permission.notification.request();

    // Once permission dialog is dismissed, handle the result
    await handlePermissionResult(context);
  }

  Future<void> handlePermissionResult(BuildContext context) async {
    // Request the notification permission
    final status = await Permission.notification.status;

    // Check if permission is granted or denied
    if (status.isGranted) {
      // If granted, navigate to the HomeScreen
      if (Platform.isIOS) {
        await initializeNotifications();
        Navigator.push(context, createRoute(const HomeScreen()));
      }
      Navigator.push(context, createRoute(const HomeScreen()));
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Handle denied case
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Notification permission denied'),
            duration: Duration(seconds: 2)),
      );
      // Show Snackbar 2 seconds and navigate to home screen
      await Future.delayed(const Duration(seconds: 2));
      Navigator.push(context, createRoute(const HomeScreen()));
    }
  }
}
