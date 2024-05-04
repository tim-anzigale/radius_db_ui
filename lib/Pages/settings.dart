import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              title: const Text('Notifications'),
              trailing: Switch(
                value: true, // Replace with actual value from preferences
                onChanged: (value) {
                  // Update notification preference
                },
              ),
            ),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: false, // Replace with actual value from preferences
                onChanged: (value) {
                  // Update dark mode preference
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
