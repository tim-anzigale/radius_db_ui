import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'user_data.dart';

class UserStats extends StatelessWidget {
    final List<UserData> userDataList;

    const UserStats({super.key, required this.userDataList});

    @override
    Widget build(BuildContext context) {
        // Calculates the number of total, new, active, and terminated subscriptions
        int totalUsers = userDataList.length;
        int newSubscriptions = userDataList
            .where((userData) {
                // Use DateFormat to parse the date string
                final dateFormat = DateFormat("M/d/yyyy HH:mm:ss.SSS'Z'");
                final createdAtDate = dateFormat.parse(userData.createdAtString);
                return DateTime.now().difference(createdAtDate).inDays < 30;
            })
            .length;
        int activeSubscriptions = userDataList.where((userData) => !userData.isTerminated).length;
        int terminatedSubscriptions = userDataList.where((userData) => userData.isTerminated).length;

        // Define the grid layout based on screen width for responsive design
        final screenWidth = MediaQuery.of(context).size.width;
        final crossAxisCount = screenWidth > 800 ? 4 : screenWidth > 600 ? 2 : 1;

        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3, // Adjust aspect ratio as needed
                ),
                itemCount: 4, // Number of items (cards)
                itemBuilder: (context, index) {
                    switch (index) {
                        case 0:
                            return _buildStatsCard(
                                title: 'Total Subscriptions',
                                value: totalUsers.toString(),
                                color: Colors.blue,
                            );
                        case 1:
                            return _buildStatsCard(
                                title: 'New Subscriptions',
                                value: newSubscriptions.toString(),
                                color: Colors.green,
                            );
                        case 2:
                            return _buildStatsCard(
                                title: 'Active Subscriptions',
                                value: activeSubscriptions.toString(),
                                color: Colors.orange,
                            );
                        case 3:
                            return _buildStatsCard(
                                title: 'Terminated Subscriptions',
                                value: terminatedSubscriptions.toString(),
                                color: Colors.red,
                            );
                        default:
                            return const SizedBox.shrink(); // In case of unexpected index
                    }
                },
            ),
        );
    }

    // Function to build a stats card
    Widget _buildStatsCard({required String title, required String value, required Color color}) {
        return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: color.withOpacity(0.15)
                ),
                borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
                children: [
                    // Icon (replace with desired icon if needed)
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            shape: BoxShape.circle,
                        ),
                        child: Icon(
                            Icons.people,
                            color: color,
                            size: 24,
                        ),
                    ),
                    // Expanded child to hold title and value
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: color,
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}
