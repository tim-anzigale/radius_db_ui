import 'package:flutter/material.dart';
import '../data/data_service.dart'; // Import parseUserData from data_service.dart
import '../user_data.dart'; // Import the UserData class
import '../components/neumorphic.dart'; // Import the FlatNeumorphismDesign

class RecentSubscriptionsView extends StatefulWidget {
  const RecentSubscriptionsView({super.key, required List<UserData> userDataList});

  @override
  // ignore: library_private_types_in_public_api
  _RecentSubscriptionsViewState createState() => _RecentSubscriptionsViewState();
}

class _RecentSubscriptionsViewState extends State<RecentSubscriptionsView> {
  late Future<List<UserData>> _futureUserData;
  List<UserData> _users = [];
  List<UserData> _filteredUsers = []; // Filtered list based on date
  double _fontSize = 16; // Initial font size

  @override
  void initState() {
    super.initState();
    _futureUserData = parseUserData(); // Fetch user data from your data service
  }

  void _filterRecentUsers() {
    final DateTime now = DateTime.now();
    final DateTime cutoffDate = now.subtract(const Duration(days: 60));

    _filteredUsers = _users.where((user) {
      return user.createdAt.isAfter(cutoffDate);
    }).toList();
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
        } else if (snapshot.hasData) {
          _users = snapshot.data!;
          _filterRecentUsers();

          return LayoutBuilder(
            builder: (context, constraints) {
              // Recalculate font size based on screen width
              _fontSize = constraints.maxWidth > 600 ? 12 : 10;
              return FlatNeumorphismDesign( // Wrap with FlatNeumorphismDesign
                child: _buildRecentSubscriptions(context),
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildRecentSubscriptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Recent Subscriptions',
                style: TextStyle(
                  fontSize: _fontSize + 4, // Slightly larger for the title
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: Text('Name', textAlign: TextAlign.center)),
              Expanded(child: Text('IP', textAlign: TextAlign.center)),
              Expanded(child: Text('NAS', textAlign: TextAlign.center)),
              Expanded(child: Text('MAC', textAlign: TextAlign.center)),
              Expanded(child: Text('Connection Date', textAlign: TextAlign.center)),
              Expanded(child: Text('Status', textAlign: TextAlign.center)),
            ],
          ),
        ),
        SizedBox(
          height: 550, // Adjusted to fit the pagination controls
          child: ListView.builder(
            itemCount: _filteredUsers.length > 10 ? 10 : _filteredUsers.length, // Limit to 10 items
            itemBuilder: (context, index) {
              final user = _filteredUsers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: FlatNeumorphismDesign(
                  child: Container(
                    height: 70, // Minimum height for each row
                    padding: const EdgeInsets.symmetric(vertical: 10), // Increased padding
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Text(user.name, textAlign: TextAlign.center, style: TextStyle(fontSize: _fontSize))),
                        Expanded(child: Text(user.ip, textAlign: TextAlign.center, style: TextStyle(fontSize: _fontSize))),
                        Expanded(child: Text(user.nas, textAlign: TextAlign.center, style: TextStyle(fontSize: _fontSize))),
                        Expanded(child: Text(user.macAdd, textAlign: TextAlign.center, style: TextStyle(fontSize: _fontSize))),
                        Expanded(child: Text(user.createdAtString, textAlign: TextAlign.center, style: TextStyle(fontSize: _fontSize))), // Using createdAtString
                        Expanded(
                          child: Text(
                            user.isDisconnected
                                ? 'Disconnected'
                                : user.isTerminated
                                    ? 'Terminated'
                                    : 'Connected',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: _fontSize,
                              color: user.isDisconnected
                                  ? Colors.red
                                  : user.isTerminated
                                      ? Colors.orange
                                      : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
