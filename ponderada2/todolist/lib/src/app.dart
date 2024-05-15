import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_service.dart';
import 'settings/settings_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'auth/login_view.dart';
import 'auth/register_view.dart';
import 'task/task_view.dart';
import 'providers/task_data.dart'; // Certifique-se de importar TaskData

void main () async {
  await dotenv.load();
  final settingsService = SettingsService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsController(settingsService)),
        ChangeNotifierProvider(create: (context) => TaskData()),
      ],
      child: MyApp(settingsController: SettingsController(settingsService)),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],

          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          
          initialRoute: LoginView.routeName,

          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case LoginView.routeName:
                    return const LoginView();
                  case '/register':
                    return RegisterView();
                  case TaskView.routeName:
                    return TaskView();
                  default:
                    return const LoginView();
                }
              },
            );
          },
        );
      },
    );
  }
}
