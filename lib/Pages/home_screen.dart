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
            body: SingleChildScrollView( // Make the home screen scrollable
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
                                    const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-4, -4),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                    ),
                                ],
                            ),
                            child: RecentSubscriptionsView(userDataList: userDataList),
                            width: double.infinity, // Ensure the view occupies full width
                        ),
                        // Create a GridView for Top Plans and Subscriptions Chart
                        GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: MediaQuery.of(context).size.width >= 800 ? 2 : 1, // 2 columns on larger screens, 1 on smaller screens
                            childAspectRatio: 1.0, // Adjust the aspect ratio of each grid item
                            physics: const NeverScrollableScrollPhysics(), // Prevent scrolling inside the grid view
                            mainAxisSpacing: 16.0, // Vertical spacing between grid items
                            crossAxisSpacing: 16.0, // Horizontal spacing between grid items
                            children: [
                                // Top Plans View
                                Container(
                                    padding: const EdgeInsets.all(16.0),
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
                                            const BoxShadow(
                                                color: Colors.white,
                                                offset: Offset(-4, -4),
                                                blurRadius: 8,
                                                spreadRadius: 1,
                                            ),
                                        ],
                                    ),
                                    child: TopPlansView(userDataList: userDataList),
                                ),
                                // Subscriptions Chart View
                                Container(
                                    padding: const EdgeInsets.all(16.0),
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
                                            const BoxShadow(
                                                color: Colors.white,
                                                offset: Offset(-4, -4),
                                                blurRadius: 8,
                                                spreadRadius: 1,
                                            ),
                                        ],
                                    ),
                                    child: SubscriptionsBarChart(userDataList: userDataList),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }
}
