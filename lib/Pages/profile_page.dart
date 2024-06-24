import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/neumorphic.dart'; 
import '../theme_provider.dart';
import '../Theme/theme_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://example.com/your-profile-picture.jpg'),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Tim',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'System Admin',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                _buildProfileDetail('Email', 'tim@inet.africa'),
                _buildProfileDetail('Phone', '+254 746 594 585'),
                _buildProfileDetail('Address', 'Malindi, Kenya'),
                // Add more details here as needed
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your logout logic here
                      Navigator.pushReplacementNamed(context, '/login'); // Example: Navigate to login page
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(detail),
        ],
      ),
    );
  }
}
