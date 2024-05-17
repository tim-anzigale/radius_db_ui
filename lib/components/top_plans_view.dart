import 'package:flutter/material.dart';
import '../data/data_service.dart'; // Import parseUserData from data_service.dart
import '../user_data.dart'; // Import the UserData class
import '../components/neumorphic.dart'; // Import the FlatNeumorphismDesign

class TopPlansView extends StatefulWidget {
  const TopPlansView({Key? key, required List<UserData> userDataList})
      : super(key: key);

  @override
  _TopPlansViewState createState() => _TopPlansViewState();
}

class _TopPlansViewState extends State<TopPlansView> {
  late Future<List<UserData>> _futureUserData;
  double _fontSize = 12; // Initial font size

  @override
  void initState() {
    super.initState();
    // Load and parse user data asynchronously
    _futureUserData = parseUserData();
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
          // Data loaded successfully
          final sortedPlans = _getSortedPlans(snapshot.data!);
          return LayoutBuilder(
            builder: (context, constraints) {
              // Recalculate font size based on screen width
              _fontSize = constraints.maxWidth > 600 ? 12 : 9;
              return _buildTopPlansSection(context, sortedPlans);
            },
          );
        }
      },
    );
  }

  // Function to calculate and sort plans based on user data
  List<MapEntry<String, int>> _getSortedPlans(List<UserData> userDataList) {
    final Map<String, int> planFrequency = {};
    for (var user in userDataList) {
      planFrequency[user.planName] = (planFrequency[user.planName] ?? 0) + 1;
    }
    final sortedPlans = planFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedPlans;
  }

  // Function to build the top plans section
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

  // Function to build the title section
  Widget _buildTitleSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Top Plans',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle "View All" action (e.g., navigate to another screen)
            },
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the list of top plans
  Widget _buildTopPlansList(
      BuildContext context, List<MapEntry<String, int>> sortedPlans) {
    return ListView.builder(
      itemCount: sortedPlans.length,
      itemBuilder: (context, index) {
        final planName = sortedPlans[index].key;
        final frequency = sortedPlans[index].value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: FlatNeumorphismDesign(
            child: ListTile(
              title: Text(
                planName,
                style: TextStyle(fontSize: _fontSize), // Apply font size
              ),
              trailing: Text(
                '$frequency users',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Colors.grey[100], // Light grey background for each item
            ),
          ),
        );
      },
    );
  }
}
