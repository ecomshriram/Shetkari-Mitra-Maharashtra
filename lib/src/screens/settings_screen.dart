import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ListTile(
            title: Text('Language'),
            subtitle: Text('English (Marathi coming soon)'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Security Audit (Certificate)'),
            subtitle: Text('View uploaded certificate'),
            onTap: () async {
              // show certificate from assets
            },
          ),
          ListTile(
            title: Text('Contact Support'),
            subtitle: Text('+91 9511760650'),
            onTap: () {},
          ),
        ],
      ),
    ));
  }
}
