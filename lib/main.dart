import 'dart:io';

import 'package:accessibility/accessibility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:swift_control/pages/requirements.dart';
import 'package:swift_control/theme.dart';
import 'package:swift_control/utils/actions/android.dart';
import 'package:swift_control/utils/actions/desktop.dart';
import 'package:swift_control/utils/actions/remote.dart';
import 'package:swift_control/utils/settings/settings.dart';
import 'package:window_manager/window_manager.dart';

import 'bluetooth/connection.dart';
import 'utils/actions/base_actions.dart';

final connection = Connection();
late BaseActions actionHandler;
final accessibilityHandler = Accessibility();
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final settings = Settings();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeActions(true);
  if (actionHandler is DesktopActions) {
    // Must add this line.
    await windowManager.ensureInitialized();
  }

  runApp(const SwiftPlayApp());
}

Future<void> initializeActions(bool local) async {
  if (kIsWeb) {
    actionHandler = StubActions();
  } else if (Platform.isAndroid) {
    if (local) {
      actionHandler = AndroidActions();
    } else {
      actionHandler = RemoteActions();
    }
  } else if (Platform.isIOS) {
    actionHandler = RemoteActions();
  } else {
    actionHandler = DesktopActions();
  }
}

class SwiftPlayApp extends StatelessWidget {
  const SwiftPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwiftControl',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: const RequirementsPage(),
    );
  }
}
