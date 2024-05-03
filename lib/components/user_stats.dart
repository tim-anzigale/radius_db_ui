import 'package:flutter/material.dart';
import '../user_data.dart';

class UserStats extends StatelessWidget {
    final List<UserData> userDataList;

    const UserStats({super.key, required this.userDataList});

    @override
    Widget build(BuildContext context) {
        // Calculate statistics
        final int totalSubscriptions = userDataList.length;
        final int newSubscriptions = userDataList.where((user) {
            final createdAt = user.createdAt;
            final daysSinceCreated = DateTime.now().difference(createdAt).inDays;
            return daysSinceCreated <= 30;
        }).length;

        final int activeSubscriptions = userDataList.where((user) => !user.isTerminated).length;
        final int terminatedSubscriptions = userDataList.where((user) => user.isTerminated).length;

        // Determine the number of columns based on screen width
        final double screenWidth = MediaQuery.of(context).size.width;
        int crossAxisCount;

        if (screenWidth >= 800) {
            // Desktop screen: display cards inline horizontally
            crossAxisCount = 4;
        } else {
            // Smaller screens: display cards on a grid
            crossAxisCount = 2;
        }

        // Create a GridView to display the stats cards
        return GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            childAspectRatio: crossAxisCount == 4 ? 2.5 : 1, // Aspect ratio based on columns
            children: [
                _buildStatsCard(
                    icon: Icons.people,
                    title: 'Total Subscriptions',
                    value: totalSubscriptions.toString(),
                    color: Colors.green,
                ),
                _buildStatsCard(
                    icon: Icons.add,
                    title: 'New Subscriptions',
                    value: newSubscriptions.toString(),
                    color: Colors.green,
                ),
                _buildStatsCard(
                    icon: Icons.people,
                    title: 'Active Subscriptions',
                    value: activeSubscriptions.toString(),
                    color: Colors.green,
                ),
                _buildStatsCard(
                    icon: Icons.remove,
                    title: 'Terminated Subscriptions',
                    value: terminatedSubscriptions.toString(),
                    color: Colors.red,
                ),
            ],
        );
    }

    // Helper function to build a stats card
    Widget _buildStatsCard({
        required IconData icon,
        required String title,
        required String value,
        required Color color,
    }) {
        return Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15), // Reduced radius for more rectangular cards
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
            child: Row(
                children: [
                    // Icon with circular background
                    Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: color),
                    ),
                    const SizedBox(width: 16),
                    // Title and value
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14, // Adjusted title font size
                                    ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                    value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24, // Increased number font size
                                        color: color,
                                    ),
                                ),
                            ],
                        ),
                    ),
                ],
            ),
        );
    }
}
