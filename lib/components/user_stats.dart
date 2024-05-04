import 'package:flutter/material.dart';
import '../user_data.dart';
import '../data/data_service.dart'; 

class UserStats extends StatefulWidget {
  const UserStats({super.key, required List<UserData> userDataList});

  @override
  // ignore: library_private_types_in_public_api
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
          return const Center(child: Text('No data available'));
        } else {
          List<UserData> userDataList = snapshot.data!;
          return _buildStatsGrid(userDataList, context);
        }
      },
    );
  }

  Widget _buildStatsGrid(List<UserData> userDataList, BuildContext context) {
    Theme.of(context);

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
  // Set initial sizes
  double fontSize = 16.0; // Initial text size
  double iconSize = 24.0; // Initial icon size

  // Calculate available width for the text and icon
  final availableWidth = MediaQuery.of(context).size.width - (2 * 16); // Account for padding

  // Measure the width required for the title and value texts
  final titleTextSpan = TextSpan(text: title, style: TextStyle(fontSize: fontSize));
  final valueTextSpan = TextSpan(text: value, style: TextStyle(fontSize: fontSize));
  
  final titleTextPainter = TextPainter(text: titleTextSpan, textDirection: TextDirection.ltr);
  final valueTextPainter = TextPainter(text: valueTextSpan, textDirection: TextDirection.ltr);
  
  titleTextPainter.layout();
  valueTextPainter.layout();
  
  // Calculate total width needed for the texts and icon
  final requiredWidth = titleTextPainter.width + valueTextPainter.width + iconSize + 12.0;

  // If there is overflow, adjust the sizes
  if (requiredWidth > availableWidth) {
    // Calculate a scaling factor to fit the content
    final scaleFactor = availableWidth / requiredWidth;

    // Adjust font and icon sizes based on the scaling factor
    fontSize = (fontSize * scaleFactor).clamp(12.0, 16.0); // Limit font size to a range
    iconSize = (iconSize * scaleFactor).clamp(18.0, 24.0); // Limit icon size to a range
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.all(8.0),
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
        // Icon container
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: iconSize),
        ),
        const SizedBox(width: 12),
        // Expanded child
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.subtitle1?.color,
                ),
              ),
              const SizedBox(height: 4),
              // Value
              Text(
                value,
                style: TextStyle(
                  fontSize: fontSize,
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
