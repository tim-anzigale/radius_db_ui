import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart'; // Import the theme provider

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text('Edit Profile'),
              onTap: () {
                // Navigate to profile editing page
              },
            ),
            ListTile(
              title: const Text('Change Password'),
              onTap: () {
                // Navigate to password change page
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // Perform logout action
              },
            ),
          ],
        ),
      ),
    );
  }
}
