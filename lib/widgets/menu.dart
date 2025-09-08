import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swift_control/main.dart';
import 'package:swift_control/utils/keymap/buttons.dart';
import 'package:url_launcher/url_launcher_string.dart';

List<Widget> buildMenuButtons() {
  return [
    PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text('PayPal'),
            onTap: () {
              launchUrlString('https://paypal.me/boni');
            },
          ),
          PopupMenuItem(
            child: Text('Other'),
            onTap: () {
              launchUrlString('https://github.com/sponsors/jonasbark?frequency=one-time');
            },
          ),
        ];
      },
      icon: Text('Donate ♥', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    ),
    SizedBox(width: 8),
    const MenuButton(),
    SizedBox(width: 8),
  ];
}

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder:
          (c) => [
            if (kDebugMode) ...[
              ...ZwiftButton.values.map(
                (e) => PopupMenuItem(
                  child: Text(e.name),
                  onTap: () {
                    Future.delayed(Duration(seconds: 2)).then((_) {
                      actionHandler.performAction(e);
                    });
                  },
                ),
              ),
              PopupMenuItem(child: PopupMenuDivider()),
            ],
            PopupMenuItem(
              child: Text('Feedback'),
              onTap: () {
                launchUrlString('https://github.com/jonasbark/swiftcontrol/issues');
              },
            ),
            PopupMenuItem(
              child: Text('License'),
              onTap: () {
                showLicensePage(context: context);
              },
            ),
          ],
    );
  }
}
