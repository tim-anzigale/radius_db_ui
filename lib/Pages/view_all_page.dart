import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/theme_provider.dart';
import '../user_data.dart';
import '../components/user_stats.dart';
import '../components/subscription_view.dart';
import '../navigation_drawer.dart';
import '../components/header.dart';
import '../components/neumorphic.dart'; // Import the Neumorphism design

class ViewAllSubscriptionsPage extends StatelessWidget {
  final List<UserData> userDataList;

  const ViewAllSubscriptionsPage({super.key, required this.userDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Subscriptions'),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomHeader(),
           // SizedBox(height:10),
           // UserStats(userDataList: userDataList),
            const SizedBox(height: 16),
            _buildSubscriptionsContainer(context),
          ],
        ),
      ),
    );
  }

    Widget _buildSubscriptionsContainer(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return isDarkMode
        ? DarkFlatNeumorphismDesign(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: SubscriptionsView(subscriptions: [],),
            ),
          )
        : FlatNeumorphismDesign(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: SubscriptionsView(subscriptions: [],),
            ),
          );
  }
}


