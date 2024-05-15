import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/providers/task_data.dart'; 

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => settingsController),
        ChangeNotifierProvider(create: (context) => TaskData()),
      ],
      child: MyApp(settingsController: settingsController),
    ),
  );
}
