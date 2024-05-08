import 'package:flutter/material.dart';
import '../data/data_service.dart';
import '../user_data.dart';

// Data source class for managing data in PaginatedDataTable
class UserDataDataSource extends DataTableSource {
  final List<UserData> userDataList;

  UserDataDataSource(this.userDataList);

  @override
  int get rowCount => userDataList.length;

  @override
  DataRow? getRow(int index) {
    if (index >= userDataList.length) {
      return null;
    }
    final user = userDataList[index];

    return DataRow(
      cells: [
        DataCell(Text(user.name)),
        DataCell(Text(user.ip)),
        DataCell(Text(user.macAdd)),
        DataCell(Text(user.createdAtString)),
        DataCell(
          Text(
            user.isDisconnected
                ? 'Disconnected'
                : user.isTerminated
                    ? 'Terminated'
                    : 'Connected',
            style: TextStyle(
              color: user.isDisconnected
                  ? Colors.red
                  : user.isTerminated
                      ? Colors.orange
                      : Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

// RecentSubscriptionsView class
class RecentSubscriptionsView extends StatefulWidget {
  final List<UserData> userDataList;

  const RecentSubscriptionsView({super.key, required this.userDataList});

  @override
  _RecentSubscriptionsViewState createState() =>
      _RecentSubscriptionsViewState();
}

// State class for RecentSubscriptionsView
class _RecentSubscriptionsViewState extends State<RecentSubscriptionsView> {
  late Future<List<UserData>> _futureUserData;
  late UserDataDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    // Fetch data asynchronously
    _futureUserData = parseUserData();
  }

  // Filter recent users based on connection date
  List<UserData> filterRecentUsers(List<UserData> users) {
    final currentDate = DateTime.now();
    final cutoffDate = currentDate.subtract(const Duration(days: 30));

    return users.where((user) {
      final connectionDate = user.createdAt;
      return connectionDate.isAfter(cutoffDate) &&
          connectionDate.isBefore(currentDate);
    }).take(15).toList(); // Return the first 15 filtered users
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
          // Filter the user data based on recent connection date
          final filteredUsers = filterRecentUsers(snapshot.data!);

          // Create a data source for the data table
          _dataSource = UserDataDataSource(filteredUsers);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Recent Subscriptions',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('IP')),
                    DataColumn(label: Text('MAC')),
                    DataColumn(label: Text('Connection Date')),
                    DataColumn(label: Text('Status')),
                  ],
                  source: _dataSource,
                  rowsPerPage: 10, // Adjust as needed
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
