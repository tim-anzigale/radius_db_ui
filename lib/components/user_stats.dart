import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/components/user_stats_gridview.dart';
import '../classes/subscription_class.dart';
import '../services/api_service.dart'; // Import the updated api_service.dart
import '../components/neumorphic.dart';
import '../theme_provider.dart'; // Import the theme provider

class UserStats extends StatefulWidget {
  const UserStats({super.key, required this.subscriptions});

  final List<Subscription> subscriptions;

  @override
  _UserStatsState createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  late Future<List<Subscription>> _futureSubscriptions;
  List<Subscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _futureSubscriptions = fetchSubscriptions(); // Fetch subscriptions from API
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subscription>>(
      future: _futureSubscriptions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          _subscriptions = snapshot.data!;
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: UserStatsCardGridView(subscriptions: _subscriptions),
          );
        } else {
          return const Center(child: Text('No data available'));
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
    double circleSize = iconSize + 16;

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return isDarkMode
        ? DarkFlatNeumorphismDesign(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCardContent(context, circleSize, iconSize, valueFontSize, titleFontSize, arrowSize, percentageFontSize),
            ),
          )
        : FlatNeumorphismDesign(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCardContent(context, circleSize, iconSize, valueFontSize, titleFontSize, arrowSize, percentageFontSize),
            ),
          );
  }

  Widget _buildCardContent(BuildContext context, double circleSize, double iconSize, double valueFontSize, double titleFontSize, double arrowSize, double percentageFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: iconSize,
                    color: color,
                  ),
                ),
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
