import 'package:flutter/material.dart';
import 'package:linked_lights/app/app.bottomsheets.dart';
import 'package:linked_lights/app/app.dialogs.dart';
import 'package:linked_lights/app/app.locator.dart';
import 'package:linked_lights/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        textTheme: Typography().white.apply(
              fontFamily: 'ArchitypeRenner',
            ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
        ),
      ),
      theme: ThemeData(fontFamily: "ArchitypeRenner"),
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
