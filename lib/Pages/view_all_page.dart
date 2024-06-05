import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/classes/subscription_class.dart';
import 'package:radius_db_ui/theme_provider.dart';
import '../components/subscription_view.dart';
import '../navigation_drawer.dart';
import '../components/header.dart';
import '../components/neumorphic.dart'; // Import the Neumorphism design

class ViewAllSubscriptionsPage extends StatelessWidget {
  final List<Subscription> subscriptions;

  const ViewAllSubscriptionsPage({super.key, required this.subscriptions});

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SubscriptionsView(subscriptions: subscriptions),
            ),
          )
        : FlatNeumorphismDesign(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SubscriptionsView(subscriptions: subscriptions),
            ),
          );
  }
}
