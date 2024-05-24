import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/home_screen.dart'; // Import your HomeScreen
import './pages/subscriptions_page.dart'; // Import SubscriptionsPage
import './pages/settings.dart'; // Import the settings page
import 'user_data.dart'; // Import your user data class
import 'theme_provider.dart'; // Import the theme provider
import './Theme/theme_manager.dart'; // Import the theme manager

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assume you have a list of user data available
    final List<UserData> userDataList = []; // Replace with your user data loading logic

    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Radius App',
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.buildLightTheme(),
      darkTheme: ThemeManager.buildDarkTheme(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(userDataList: userDataList),
        '/subscriptions': (context) => SubscriptionsPage(userDataList: userDataList),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
