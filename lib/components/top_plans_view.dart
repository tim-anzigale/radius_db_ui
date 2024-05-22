import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_service.dart';
import '../user_data.dart';
import '../components/neumorphic.dart';
import '../theme_provider.dart'; // Import the theme provider

class TopPlansView extends StatefulWidget {
  final List<UserData> userDataList;

  const TopPlansView({Key? key, required this.userDataList}) : super(key: key);

  @override
  _TopPlansViewState createState() => _TopPlansViewState();
}

class _TopPlansViewState extends State<TopPlansView> {
  late Future<List<UserData>> _futureUserData;
  double _fontSize = 13;

  @override
  void initState() {
    super.initState();
    _futureUserData = parseUserData(); // Load and parse user data asynchronously
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
          final sortedPlans = _getSortedPlans(snapshot.data!);
          return LayoutBuilder(
            builder: (context, constraints) {
              // _fontSize = constraints.maxWidth > 600 ? 12 : 9;
              return _buildTopPlansSection(context, sortedPlans);
            },
          );
        }
      },
    );
  }

  List<MapEntry<String, int>> _getSortedPlans(List<UserData> userDataList) {
    final Map<String, int> planFrequency = {};
    for (var user in userDataList) {
      planFrequency[user.planName] = (planFrequency[user.planName] ?? 0) + 1;
    }
    final sortedPlans = planFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedPlans;
  }

  Widget _buildTopPlansSection(
      BuildContext context, List<MapEntry<String, int>> sortedPlans) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleSection(context),
        const SizedBox(height: 10),
        Expanded(
          child: _buildTopPlansList(context, sortedPlans),
        ),
      ],
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Plans',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPlansList(
      BuildContext context, List<MapEntry<String, int>> sortedPlans) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return ListView.builder(
      itemCount: sortedPlans.length,
      itemBuilder: (context, index) {
        final planName = sortedPlans[index].key;
        final frequency = sortedPlans[index].value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: ListTile(
            title: Text(
              planName,
              style: TextStyle(
                fontSize: _fontSize,
                color: isDarkMode ? Colors.grey[200] : Colors.black,
              ),
            ),
            trailing: Text(
              '$frequency',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey[200] : Colors.black,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
          ),
        );
      },
    );
  }
}
