import 'package:flutter/material.dart';
import 'package:radius_db_ui/components/view_all.dart';
import '../data/data_service.dart';
import '../user_data.dart';
import '../Pages/view_all_page.dart';

class RecentSubscriptionsView extends StatefulWidget {
  const RecentSubscriptionsView({super.key, required this.userDataList});

  final List<UserData> userDataList;

  @override
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
    final DateTime cutoffDate = now.subtract(const Duration(days: 30));

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
              _fontSize = constraints.maxWidth > 600 ? 13 : 10;
              return _buildRecentSubscriptions(context);
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildRecentSubscriptions(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Recent Subscriptions',
                style: TextStyle(
                  fontSize: _fontSize + 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ViewAllText(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewAllSubscriptionsPage(userDataList: _users),
                ));
              },
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columnSpacing: screenWidth * 0.07, // Adjust spacing between columns
              columns: [
                DataColumn(label: Text('Name', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('IP', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('NAS', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('MAC', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('Connection Date', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('Status', style: TextStyle(fontSize: _fontSize))),
              ],
              rows: _filteredUsers.take(10).map((user) {
                return DataRow(
                  cells: [
                    DataCell(Text(user.name, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Text(user.ip, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Text(user.nas, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Text(user.macAdd, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Text(user.createdAtString, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Container(
                      width: 110,
                      decoration: BoxDecoration(
                        color: user.isDisconnected
                            ? Colors.red.withOpacity(0.1)
                            : user.isTerminated
                                ? Colors.orange.withOpacity(0.1)
                                : Colors.green.withOpacity(0.1),
                        border: Border.all(
                          color: user.isDisconnected
                              ? Colors.red
                              : user.isTerminated
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
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
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
