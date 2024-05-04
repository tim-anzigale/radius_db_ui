import 'package:flutter/material.dart';
import '../user_data.dart'; // Import your user data class
import '../components/user_stats.dart'; // Import the stats view
import '../components/subscription_view.dart';
import '../navigation_drawer.dart';
import '../components/header.dart';

class SubscriptionsPage extends StatelessWidget {
  final List<UserData> userDataList;

  const SubscriptionsPage({super.key, required this.userDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(), // Assuming NavigationDrawer is the correct widget
      appBar: AppBar(
        title: const Text('Subscriptions'),
      ),
      // Wrap the body with SingleChildScrollView for scrollability
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomHeader(),
            // Remove the container wrapping UserStats
            // Directly add UserStats widget
            UserStats(userDataList: userDataList),

            // All subscriptions view with its own container and styling
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const SubscriptionsView(),
            ),
          ],
        ),
      ),
    );
  }
}
