import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Switch(
                value: true, // Replace with actual value from preferences
                onChanged: (value) {
                  // Update notification preference
                },
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: false, // Replace with actual value from preferences
                onChanged: (value) {
                  // Update dark mode preference
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                // Navigate to profile editing page
              },
            ),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                // Navigate to password change page
              },
            ),
            ListTile(
              title: Text('Logout'),
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
