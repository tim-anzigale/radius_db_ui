import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/recent_subscriptions_view.dart';
import '../components/top_plans_view.dart';
import '../components/subscriptions_chart.dart';
import '../navigation_drawer.dart';
import '../user_data.dart';
import '../components/neumorphic.dart';

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
            const CustomHeader(),
            const SizedBox(height: 5),
            RecentSubscriptionsView(userDataList: userDataList),
            const SizedBox(height: 10),
            _buildGridSection(context),
          ],
        ),
      ),
    );
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
        FlatNeumorphismDesign(
          child: TopPlansView(userDataList: userDataList),
        ),
        FlatNeumorphismDesign(
          child: SubscriptionsBarChart(userDataList: userDataList),
        ),
      ],
    );
  }
}


