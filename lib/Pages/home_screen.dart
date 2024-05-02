import 'package:flutter/material.dart';
import '../user_data.dart'; // Import your user data class
import '../components/recent_subscriptions_view.dart'; // Import the recent subscriptions view
import '../components/top_plans_view.dart'; // Import the top plans view
import '../components/subscriptions_chart.dart'; // Import the subscriptions chart view
import '../navigation_drawer.dart';

class HomeScreen extends StatelessWidget {
    final List<UserData> userDataList;

    const HomeScreen({super.key, required this.userDataList});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            drawer: const SideMenu(),
            appBar: AppBar(
                title: const Text('Home'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                        // Top view: Recent Subscriptions
                        Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(bottom: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        offset: Offset(4, 4),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                    ),
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-4, -4),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                    ),
                                ],
                            ),
                            child: RecentSubscriptionsView(userDataList: userDataList),
                        ),
                        // Lower portion: Two views side by side
                        Expanded(
                            child: Row(
                                children: [
                                    // Left side: Top Plans
                                    Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            margin: const EdgeInsets.only(right: 8.0),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.circular(15),
                                                boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.shade400,
                                                        offset: Offset(4, 4),
                                                        blurRadius: 8,
                                                        spreadRadius: 1,
                                                    ),
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        offset: Offset(-4, -4),
                                                        blurRadius: 8,
                                                        spreadRadius: 1,
                                                    ),
                                                ],
                                            ),
                                            child: TopPlansView(userDataList: userDataList),
                                        ),
                                    ),
                                    // Right side: Subscriptions Chart
                                    Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            margin: const EdgeInsets.only(left: 8.0),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.circular(15),
                                                boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.shade400,
                                                        offset: Offset(4, 4),
                                                        blurRadius: 8,
                                                        spreadRadius: 1,
                                                    ),
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        offset: Offset(-4, -4),
                                                        blurRadius: 8,
                                                        spreadRadius: 1,
                                                    ),
                                                ],
                                            ),
                                            child: SubscriptionsChart(userDataList: userDataList),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
