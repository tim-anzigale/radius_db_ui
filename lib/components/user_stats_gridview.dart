 import 'package:flutter/material.dart';
import '../user_data.dart';
import '../components/user_stats.dart';

class UserStatsCardGridView extends StatelessWidget {
  const UserStatsCardGridView({Key? key, required this.userDataList}) : super(key: key);

  final List<UserData> userDataList;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth >= 600 ? 4 : 2;
    double childAspectRatio;

    // Determine the child aspect ratio based on screen width
    if (screenWidth >= 1200) {
      childAspectRatio = 2.6; // Larger screens (e.g., tablets, laptops)
    } else if (screenWidth >= 800) {
      childAspectRatio = 1.5; // Medium screens (e.g., large tablets)
    } else {
      childAspectRatio = 1.6; // Mobile screens
    }

    final totalSubscriptions = userDataList.length;
    final recentSubscriptions = userDataList.where((user) {
      final currentDate = DateTime.now();
      return currentDate.difference(user.createdAt).inDays <= 30;
    }).length;
    final activeSubscriptions = userDataList.where((user) => !user.isTerminated).length;
    final terminatedSubscriptions = userDataList.where((user) => user.isTerminated).length;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return UserStatsCard(
              icon: Icons.people,
              title: 'Total Subscriptions',
              value: totalSubscriptions.toString(),
              color: Colors.green,
              trend: 5, // Positive trend
            );
          case 1:
            return UserStatsCard(
              icon: Icons.person_add,
              title: 'Recent Subscriptions',
              value: recentSubscriptions.toString(),
              color: Colors.green,
              trend: -3, // Negative trend
            );
          case 2:
            return UserStatsCard(
              icon: Icons.check_circle,
              title: 'Active Subscriptions',
              value: activeSubscriptions.toString(),
              color: Colors.green,
              trend: 2, // Positive trend
            );
          case 3:
            return UserStatsCard(
              icon: Icons.person_remove,
              title: 'Terminated Subscriptions',
              value: terminatedSubscriptions.toString(),
              color: Colors.red,
              trend: -1, // Negative trend
            );
          default:
            return Container();
        }
      },
    );
  }
}