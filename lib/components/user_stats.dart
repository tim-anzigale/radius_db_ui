import 'package:flutter/material.dart';
import 'package:radius_db_ui/components/user_stats_gridview.dart';
import '../user_data.dart';
import '../data/data_service.dart';
import '../components/neumorphic.dart';

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

class UserStatsCard extends StatelessWidget {
  const UserStatsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.trend,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final int trend;

  @override
  Widget build(BuildContext context) {
    // Responsive size adjustments
    double iconSize = MediaQuery.of(context).size.width < 600 ? 24 : 30;
    double valueFontSize = MediaQuery.of(context).size.width < 600 ? 24 : 30;
    double titleFontSize = MediaQuery.of(context).size.width < 600 ? 10 : 12;
    double arrowSize = MediaQuery.of(context).size.width < 600 ? 16 : 20;
    double percentageFontSize = MediaQuery.of(context).size.width < 600 ? 12 : 14;

    return FlatNeumorphismDesign(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    size: iconSize,
                    color: color,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: valueFontSize,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      _buildTrendArrow(trend, arrowSize, percentageFontSize),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build trend arrows with dynamic sizing
  Widget _buildTrendArrow(int trend, double arrowSize, double percentageFontSize) {
    if (trend == 0) {
      return const SizedBox.shrink();
    }

    final IconData arrowIcon = trend > 0 ? Icons.trending_up : Icons.trending_down;
    final Color arrowColor = trend > 0 ? Colors.green : Colors.red;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          arrowIcon,
          size: arrowSize,
          color: arrowColor,
        ),
        const SizedBox(width: 2),
        Text(
          '${trend.abs()}%',
          style: TextStyle(
            fontSize: percentageFontSize,
            color: arrowColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
