import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event!['action'] == 'stopService') {
      service.stopBackgroundService();
    }
    if (event['action'] == 'updateTimer') {
      if (event['duration'] != '-1') {
        service.setNotificationInfo(
          title: 'Timer',
          content: 'Phase: ${event['phase']} Time left: ${event['duration']}',
        );
      }
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
}

Future<bool> isRunning() async {
  return await FlutterBackgroundService().isServiceRunning();
}

void startTimerService() {
  print('started');
  FlutterBackgroundService.initialize(onStart);
}

void stopTimerService() async {
  print('stoped');
  if (await isRunning()) {
    FlutterBackgroundService().sendData(
      {'action': 'stopService'},
    );
  }
}

void updateBackgroundTimer(String phase, int duration) async {
  if (await isRunning()) {
    FlutterBackgroundService().sendData(
      {
        'action': 'updateTimer',
        'phase': phase,
        'duration': '$duration',
      },
    );
  }
}
