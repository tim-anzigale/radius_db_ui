import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/components/pie_chart_widget.dart';
import 'package:radius_db_ui/components/user_stats.dart';
import '../components/header.dart';
import '../components/recent_subscriptions_view.dart';
import '../components/top_plans_view.dart';
import '../navigation_drawer.dart';
import '../user_data.dart';
import '../components/neumorphic.dart';
import '../theme_provider.dart'; // Import the theme provider

class HomeScreen extends StatelessWidget {
  final List<UserData> userDataList;

  const HomeScreen({Key? key, required this.userDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printUserInfo(); // Print user info for debugging purposes

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Home'),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomHeader(),
            const SizedBox(height: 20),
            UserStats(userDataList: userDataList),
            const SizedBox(height: 20),
            _buildNeumorphismContainer(
              context,
              RecentSubscriptionsView(userDataList: userDataList),
            ),
            const SizedBox(height: 20),
            _buildGridSection(context),
          ],
        ),
      ),
    );
  }

  // Helper function to print user information for debugging
  void printUserInfo() {
    print('UserDataList Length: ${userDataList.length}');
    for (var user in userDataList) {
      print('User: ${user.name}, Disconnected: ${user.isDisconnected}, Terminated: ${user.isTerminated}');
    }
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
        _buildNeumorphismContainer(
          context,
          TopPlansView(userDataList: userDataList),
        ),
        _buildNeumorphismContainer(
          context,
          PieChartWidget(userDataList: userDataList),
        ),
      ],
    );
  }

  // Helper function to build the Neumorphism container based on the theme
  Widget _buildNeumorphismContainer(BuildContext context, Widget child) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return isDarkMode
        ? DarkFlatNeumorphismDesign(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
          )
        : FlatNeumorphismDesign(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
          );
  }
}
