import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_app_bar.dart';
import '../models/subscription_class.dart';
import '../components/subscription_view.dart';
import '../components/header.dart';
import '../components/neumorphic.dart';
import '../theme_provider.dart'; // Import your theme provider

class SubscriptionsPage extends StatelessWidget {
  final Function(Subscription) onSubscriptionSelected;
  final DateTime? lastSyncedTime;
  final String syncStatus;

  const SubscriptionsPage({
    super.key,
    required this.onSubscriptionSelected,
    this.lastSyncedTime,
    this.syncStatus = "Not synced yet",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Subscriptions',
        lastSyncedTime: lastSyncedTime,
        syncStatus: syncStatus,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomHeader(),
            const SizedBox(height: 20),
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
              child: SubscriptionsView(
                onSubscriptionSelected: onSubscriptionSelected,
              ),
            ),
          )
        : FlatNeumorphismDesign(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SubscriptionsView(
                onSubscriptionSelected: onSubscriptionSelected,
              ),
            ),
          );
  }
}
