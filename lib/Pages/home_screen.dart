import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/recent_subscriptions_view.dart';
import '../components/top_plans_view.dart';
import '../components/subscriptions_chart.dart';
import '../navigation_drawer.dart';
import '../user_data.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                        _buildHeader(context),
                        const SizedBox(height: 5),
                        _buildRecentSubscriptionsSection(context),
                        const SizedBox(height: 10),
                        _buildGridSection(context),
                    ],
                ),
            ),
        );
    }

    // Helper function to build the header section
    Widget _buildHeader(BuildContext context) {
        return const CustomHeader();
    }

    // Helper function to build the recent subscriptions section
    Widget _buildRecentSubscriptionsSection(BuildContext context) {
    return RecentSubscriptionsView(userDataList: userDataList);
}
    // Helper function to build the grid section
    Widget _buildGridSection(BuildContext context) {
        final bool isWideScreen = MediaQuery.of(context).size.width >= 800;
        final int crossAxisCount = isWideScreen ? 2 : 1;
        
        return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 16.0,
            children: [
                neumorphicContainer(
                    child: TopPlansView(userDataList: userDataList),
                    context: context,
                ),
                neumorphicContainer(
                    child: SubscriptionsBarChart(userDataList: userDataList),
                    context: context,
                ),
            ],
        );
    }
}

Widget neumorphicContainer({required Widget child, required BuildContext context}) {
    return Neumorphic(
        style: NeumorphicStyle(
            color: Colors.grey[200],
            depth: 4, // Adjust depth as desired
            intensity: 0.8, // Adjust intensity as desired
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)), // Rounded corners
        ),
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
            width: double.infinity, // Fill the available width
            child: InkWell(
                onTap: () {}, // Add your tap handler here if needed
                child: child,
            ),
        ),
    );
}
