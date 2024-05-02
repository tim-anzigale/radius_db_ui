import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../user_data.dart';

class UserStats extends StatelessWidget {
    final List<UserData> userDataList;

    const UserStats({super.key, required this.userDataList});

    @override
    Widget build(BuildContext context) {
        // Debug print to check input data
        print('UserStats widget initialized with ${userDataList.length} users.');

        // Calculate statistics
        final int totalSubscriptions = userDataList.length;
        print('Total subscriptions: $totalSubscriptions');

        final dateFormat = DateFormat("M/d/yyyy HH:mm:ss.SSS'Z'");
        final int newSubscriptions = userDataList.where((user) {
            if (user.createdAtString == null) {
                return false;
            }
            final createdAtDate = dateFormat.parse(user.createdAtString);
            return DateTime.now().difference(createdAtDate).inDays <= 30;
        }).length;
        print('New subscriptions: $newSubscriptions');

        final int activeSubscriptions = userDataList.where((user) => !user.isTerminated).length;
        print('Active subscriptions: $activeSubscriptions');

        final int terminatedSubscriptions = userDataList.where((user) => user.isTerminated).length;
        print('Terminated subscriptions: $terminatedSubscriptions');

        return Column(
            children: [
                // Create stats cards using helper function
                _buildStatsCard(
                    icon: Icons.people,
                    title: 'Total Subscriptions',
                    value: totalSubscriptions.toString(),
                    color: Colors.blue,
                ),
                _buildStatsCard(
                    icon: Icons.add,
                    title: 'New Subscriptions',
                    value: newSubscriptions.toString(),
                    color: Colors.green,
                ),
                _buildStatsCard(
                    icon: Icons.people_outline,
                    title: 'Active Subscriptions',
                    value: activeSubscriptions.toString(),
                    color: Colors.blue,
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

    // Helper function to build stats card
    Widget _buildStatsCard({required IconData icon, required String title, required String value, required Color color}) {
        return Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(4, 4),
                        blurRadius: 8,
                        spreadRadius: 1,
                    ),
                    BoxShadow(
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
                        padding: const EdgeInsets.all(8.0),
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
                                        fontSize: 16,
                                    ),
                                ),
                                Text(
                                    value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
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
