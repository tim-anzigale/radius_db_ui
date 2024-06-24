import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/models/subscription_class.dart';
import 'package:radius_db_ui/components/pie_chart_widget.dart';
import 'package:radius_db_ui/components/user_stats.dart';
import '../components/header.dart';
import '../components/recent_subscriptions_view.dart';
import '../components/subscriptions_bar_chart.dart';
import '../components/top_plans_view.dart';
import '../components/neumorphic.dart';
import '../theme_provider.dart'; // Import the theme provider

class HomeScreen extends StatefulWidget {
  final List<Subscription> subscriptions;
  final VoidCallback onViewAllPressed;
  final Function(Subscription) onSubscriptionSelected;
  final VoidCallback onViewMorePlans;

  const HomeScreen({
    Key? key,
    required this.subscriptions,
    required this.onViewAllPressed,
    required this.onSubscriptionSelected,
    required this.onViewMorePlans,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            UserStats(subscriptions: widget.subscriptions),
            const SizedBox(height: 20),
            _buildNeumorphismContainer(
              context,
              RecentSubscriptionsView(
                subscriptions: widget.subscriptions,
                onViewAllPressed: widget.onViewAllPressed,
                onSubscriptionSelected: widget.onSubscriptionSelected,
              ),
            ),
            const SizedBox(height: 20),
            _buildGridSection(context, widget.subscriptions),
          ],
        ),
      ),
    );
  }

  // Helper function to build the grid section
  Widget _buildGridSection(BuildContext context, List<Subscription> subscriptions) {
    final bool isWideScreen = MediaQuery.of(context).size.width >= 800;
    final int crossAxisCount = isWideScreen ? 2 : 1;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: 1.5, // Adjust this value to reduce the height of the grid items
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 16.0,
      children: [
        _buildNeumorphismContainer(
          context,
          TopPlansView(
            subscriptions: subscriptions,
            onViewMorePressed: widget.onViewMorePlans, // Pass the callback
          ),
        ),
        _buildNeumorphismContainer(
          context,
          PieChartWidget(subscriptions: subscriptions),
        ),
        _buildNeumorphismContainer(
          context,
          SubscriptionsBarChart(subscriptions: widget.subscriptions),
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
