import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../user_data.dart';

class RecentSubscriptionsView extends StatelessWidget {
    final List<UserData> userDataList;

    const RecentSubscriptionsView({super.key, required this.userDataList});

    @override
    Widget build(BuildContext context) {
        // Filter recent subscriptions (subscriptions from the last 30 days)
        final recentSubscriptions = userDataList.where((userData) {
            return DateTime.now().difference(userData.createdAt).inDays <= 30;
        }).toList();

        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text(
                    'Recent Subscriptions',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                const SizedBox(height: 10),
                // Check if there are recent subscriptions and display them
                if (recentSubscriptions.isNotEmpty)
                    Expanded(
                        child: ListView.builder(
                            itemCount: recentSubscriptions.length,
                            itemBuilder: (context, index) {
                                final subscription = recentSubscriptions[index];
                                return ListTile(
                                    leading: const Icon(Icons.person, color: Colors.blue),
                                    title: Text(subscription.name),
                                    subtitle: Text('Subscribed on ${DateFormat('M/d/yyyy').format(subscription.createdAt)}'),
                                    trailing: Text(subscription.planName),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                    tileColor: Colors.grey[100], // Light grey background for each item
                                );
                            },
                        ),
                    )
                else
                    const Text('No recent subscriptions found.'),
            ],
        );
    }
}
