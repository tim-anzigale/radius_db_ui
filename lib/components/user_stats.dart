import 'package:flutter/material.dart';
import '../user_data.dart';
import '../data/data_service.dart'; // Import your data service where parseUserData() is defined

class UserStats extends StatefulWidget {
  const UserStats({super.key, required List<UserData> userDataList});

  @override
  _UserStatsState createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  late Future<List<UserData>> _futureUserData;

  @override
  void initState() {
    super.initState();
    _futureUserData = parseUserData(); // Assume parseUserData() fetches your user data list
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
          return Center(child: Text('No data available'));
        } else {
          List<UserData> userDataList = snapshot.data!;
          return _buildStatsGrid(userDataList, context);
        }
      },
    );
  }

  Widget _buildStatsGrid(List<UserData> userDataList, BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // Calculate statistics
    final int totalSubscriptions = userDataList.length;
    final int recentSubscriptions = userDataList.where((user) {
      final currentDate = DateTime.now();
      return currentDate.difference(user.createdAt).inDays <= 30;
    }).length;
    final int activeSubscriptions = userDataList.where((user) => !user.isTerminated).length;
    final int terminatedSubscriptions = userDataList.where((user) => user.isTerminated).length;

    // Determine the layout based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth >= 800;
    final int crossAxisCount = isLargeScreen ? 4 : 2;
    final double childAspectRatio = isLargeScreen ? 2.5 : 1;

    // Create GridView for displaying stats
    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      childAspectRatio: childAspectRatio,
      padding: const EdgeInsets.all(8),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        _buildStatsCard(
          icon: Icons.people,
          title: 'Total Subscriptions',
          value: totalSubscriptions.toString(),
          color: Colors.green,
          context: context,
        ),
        _buildStatsCard(
          icon: Icons.add,
          title: 'Recent Subscriptions',
          value: recentSubscriptions.toString(),
          color: Colors.green,
          context: context,
        ),
        _buildStatsCard(
          icon: Icons.people,
          title: 'Active Subscriptions',
          value: activeSubscriptions.toString(),
          color: Colors.green,
          context: context,
        ),
        _buildStatsCard(
          icon: Icons.remove,
          title: 'Terminated Subscriptions',
          value: terminatedSubscriptions.toString(),
          color: Colors.red,
          context: context,
        ),
      ],
    );
  }
}


  Widget _buildStatsCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(10.0),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, // Center the text vertically
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
