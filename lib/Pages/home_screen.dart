import 'package:flutter/material.dart';
import '../user_data.dart'; // Import your user data class
import '../components/recent_subscriptions_view.dart'; // Import the recent subscriptions view
import '../components/top_plans_view.dart'; // Import the top plans view
import '../components/subscriptions_chart.dart'; // Import the subscriptions chart view
import '../navigation_drawer.dart';
import '../components/header.dart';

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
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0), // Increased padding around the content
                child: Column(
                    children: [
                      CustomHeader(),
                        SizedBox(height: 5), // Top spacing
                        neumorphicContainer(
                            child: RecentSubscriptionsView(userDataList: userDataList),
                            context: context
                        ),
                        SizedBox(height: 5), // Spacing between elements
                        GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: MediaQuery.of(context).size.width >= 800 ? 2 : 1,
                            childAspectRatio: 1.0,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 10.0, // Increased vertical spacing between grid items
                            crossAxisSpacing: 16.0, // Increased horizontal spacing between grid items
                            children: [
                                neumorphicContainer(
                                    child: TopPlansView(userDataList: userDataList),
                                    context: context
                                ),
                                neumorphicContainer(
                                    child: SubscriptionsBarChart(userDataList: userDataList),
                                    context: context
                                ),
                            ],
                        ),
                        SizedBox(height: 5), // Bottom spacing
                    ],
                ),
            ),
        );
    }

    Widget neumorphicContainer({required Widget child, required BuildContext context}) {
        return Container(
            padding: const EdgeInsets.all(16.0), // Increased padding inside the container
            margin: const EdgeInsets.symmetric(vertical: 10), // Margin for top/bottom for more space
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20), // Slightly increased border radius
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: Offset(6, 6),
                        blurRadius: 15,
                        spreadRadius: 1,
                    ),
                    const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-6, -6),
                        blurRadius: 15,
                        spreadRadius: 1,
                    ),
                ],
            ),
            child: InkWell(
                onTap: () {}, // Add your tap handler here
                child: child,
            ),
            width: double.infinity,
        );
    }
}
