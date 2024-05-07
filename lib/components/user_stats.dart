import 'package:flutter/material.dart';
import '../user_data.dart';
import '../data/data_service.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';


class UserStats extends StatefulWidget {
  const UserStats({super.key, required this.userDataList});

  final List<UserData> userDataList;

  @override
  // ignore: library_private_types_in_public_api
  _UserStatsState createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  late Future<List<UserData>> _futureUserData;

  @override
  void initState() {
    super.initState();
    _futureUserData = parseUserData(); // Assuming parseUserData() fetches user data
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserData>>(
      future: _futureUserData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else if (snapshot.hasData) {
          List<UserData> userDataList = snapshot.data!;
          return UserStatsCardGridView(userDataList: userDataList);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


class UserStatsCardGridView extends StatelessWidget {
  const UserStatsCardGridView({super.key, required this.userDataList});

  final List<UserData> userDataList;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth < 650 ? 2 : (screenWidth < 800 ? 3 : 4);
    final double childAspectRatio = screenWidth < 650 ? 1.5 : 1.2;

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
              color: Colors.green, // Color of icon and value
            );
          case 1:
            return UserStatsCard(
              icon: Icons.add,
              title: 'Recent Subscriptions',
              value: recentSubscriptions.toString(),
              color: Colors.green, // Color of icon and value
            );
          case 2:
            return UserStatsCard(
              icon: Icons.people,
              title: 'Active Subscriptions',
              value: activeSubscriptions.toString(),
              color: Colors.green, // Color of icon and value
            );
          case 3:
            return UserStatsCard(
              icon: Icons.remove,
              title: 'Terminated Subscriptions',
              value: terminatedSubscriptions.toString(),
              color: Colors.red, // Color of icon and value
            );
          default:
            return Container(); // This should not happen
        }
      },
    );
  }
}


class UserStatsCard extends StatelessWidget {
  const UserStatsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        color: Colors.grey[200], // Base color for the card
        depth: 4, // Adjust the depth as desired
        intensity: 0.8, // Adjust the intensity as desired
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: color, // Only value colored
                ),
              ),
              NeumorphicIcon(
                icon,
                size: 24,
                style: NeumorphicStyle(
                  color: color, // Only icon colored
                  depth: 4,
                  intensity: 0.8,
                  shape: NeumorphicShape.convex,
                  boxShape: const NeumorphicBoxShape.circle(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
