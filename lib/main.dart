import 'package:flutter/material.dart';
import './Pages/home_screen.dart'; // Import your HomeScreen
import './Pages/subscriptions_page.dart'; // Import SubscriptionsPage
import 'user_data.dart'; // Import your user data class

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        // Assume you have a list of user data available
        final List<UserData> userDataList = []; // Replace with your user data loading logic

        return MaterialApp(
            title: 'Radius App',
            theme: ThemeData(
                primarySwatch: Colors.blueGrey,
            ),
            initialRoute: '/home', // Initial route is the home screen
            routes: {
                '/home': (context) => HomeScreen(userDataList: userDataList), // Define HomeScreen route with userDataList argument
                '/subscriptions': (context) => SubscriptionsPage(userDataList: userDataList), // Define SubscriptionsPage route with userDataList argument
                // Add other routes as needed
            },
        );
    }
}
