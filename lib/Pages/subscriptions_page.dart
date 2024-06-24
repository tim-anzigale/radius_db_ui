import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/subscription_class.dart';
import '../components/subscription_view.dart';
import '../components/header.dart';
import '../components/neumorphic.dart';
import '../theme_provider.dart'; // Import your theme provider

class SubscriptionsPage extends StatelessWidget {
  final List<Subscription> subscriptions;
  final Function(Subscription) onSubscriptionSelected;

  const SubscriptionsPage({
    super.key,
    required this.subscriptions,
    required this.onSubscriptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions'),
        surfaceTintColor: Colors.transparent,
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
                subscriptions: subscriptions,
                onSubscriptionSelected: onSubscriptionSelected,
              ),
            ),
          )
        : FlatNeumorphismDesign(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SubscriptionsView(
                subscriptions: subscriptions,
                onSubscriptionSelected: onSubscriptionSelected,
              ),
            ),
          );
  }
}
