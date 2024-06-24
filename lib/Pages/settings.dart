import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart'; // Import the theme provider
import '../components/neumorphic.dart'; // Import the Neumorphism design

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FlatNeumorphismDesign(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'General Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.grey[200] : Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[200] : Colors.black,
                    ),
                  ),
                  trailing: Switch(
                    value: themeProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.grey[200] : Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[200] : Colors.black,
                    ),
                  ),
                  onTap: () {
                    // Navigate to profile editing page
                  },
                ),
                ListTile(
                  title: Text(
                    'Change Password',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[200] : Colors.black,
                    ),
                  ),
                  onTap: () {
                    // Navigate to password change page
                  },
                ),
                ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[200] : Colors.black,
                    ),
                  ),
                  onTap: () {
                    // Perform logout action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
