import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Pages/home_screen.dart'; // Import your HomeScreen
import './Pages/subscriptions_page.dart'; // Import SubscriptionsPage
import 'user_data.dart'; // Import your user data class
import 'theme_provider.dart'; // Import the theme provider
import './Pages/settings.dart'; // Import the settings page

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.grey.shade200,
        ),
        scaffoldBackgroundColor: Colors.grey.shade200,
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: 'Ubuntu_Sans_Mono',
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.grey[800],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          titleTextStyle: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 18, // Adjust size if necessary
            fontFamily: 'Ubuntu_Sans_Mono',
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey.shade200,
        ),
        dataTableTheme: DataTableThemeData(
          headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
          dataRowColor: MaterialStateProperty.all(Colors.grey.shade100),
          headingTextStyle: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
          dataTextStyle: TextStyle(
            color: Colors.grey[800],
          ),
          dividerThickness: 1.5, // Adjust as necessary
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.grey.shade900,
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Ubuntu_Sans_Mono',
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.grey[300],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey[300]),
          titleTextStyle: TextStyle(
            color: Colors.grey[300],
            fontWeight: FontWeight.bold,
            fontSize: 18, // Adjust size if necessary
            fontFamily: 'Ubuntu_Sans_Mono',
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey.shade900,
        ),
        dataTableTheme: DataTableThemeData(
          headingRowColor: MaterialStateProperty.all(Colors.grey.shade900),
          dataRowColor: MaterialStateProperty.all(Colors.grey.shade800),
          headingTextStyle: TextStyle(
            color: Colors.grey[300],
            fontWeight: FontWeight.bold,
          ),
          dataTextStyle: TextStyle(
            color: Colors.grey[300],
          ),
          dividerThickness: 1.5, // Adjust as necessary
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(userDataList: userDataList),
        '/subscriptions': (context) => SubscriptionsPage(userDataList: userDataList),
        '/settings': (context) => const SettingsPage(), // Add the settings page route
      },
    );
  }
}
