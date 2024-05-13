import 'package:flutter/material.dart';
import '../user_data.dart';
import '../components/user_stats.dart';
import '../components/subscription_view.dart';
import '../navigation_drawer.dart';
import '../components/header.dart';

class SubscriptionsPage extends StatelessWidget {
  final List<UserData> userDataList;

  const SubscriptionsPage({super.key, required this.userDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Subscriptions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomHeader(),
            UserStats(userDataList: userDataList),
            const SizedBox(height: 16),
            _buildSubscriptionsContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionsContainer() {
    // This container provides the visual styling for the subscriptions view.
    // Adjusted to ensure proper scrolling behavior if needed.
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(4, 4),
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
      
      child: const SubscriptionsView(),
    );
  }
}
