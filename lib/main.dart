import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/Pages/view_all_page.dart';
import 'package:radius_db_ui/classes/subscription_class.dart';

import './pages/home_screen.dart';
import './pages/subscriptions_page.dart';
import './pages/settings.dart';
import './pages/profile_page.dart'; // Import the profile page
import 'services/api_service.dart';
import 'theme_provider.dart';
import './Theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Fetch subscription data
  List<Subscription> subscriptions = await fetchSubscriptions();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(subscriptions: subscriptions),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<Subscription> subscriptions;

  const MyApp({Key? key, required this.subscriptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Radius App',
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.buildLightTheme(),
      darkTheme: ThemeManager.buildDarkTheme(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(subscriptions: subscriptions),
        '/subscriptions': (context) => SubscriptionsPage(subscriptions: subscriptions),
        '/view_all_subscriptions': (context) => ViewAllSubscriptionsPage(subscriptions: subscriptions),
        '/settings': (context) => const SettingsPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
