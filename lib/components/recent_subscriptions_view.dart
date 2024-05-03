import 'package:flutter/material.dart';
import '../data/data_service.dart'; // Import parseUserData from data_service.dart
import '../user_data.dart'; // Import the UserData class

class UserDataDataSource extends DataTableSource {
    final List<UserData> userDataList;

    // Constructor accepting userDataList
    UserDataDataSource(this.userDataList);

    @override
    int get rowCount => userDataList.length; // Returns the length of the list

    @override
    DataRow? getRow(int index) {
        // Check index bounds
        if (index >= userDataList.length) {
            return null;
        }
        final user = userDataList[index];

        // Return a DataRow for the user
        return DataRow(
            cells: [
                DataCell(Text(user.name)),
                DataCell(Text(user.ip)),
                DataCell(Text(user.macAdd)),
                DataCell(Text(user.createdAtString)),
                DataCell(
                    Text(
                        user.isDisconnected ? 'Disconnected' : user.isTerminated ? 'Terminated' : 'Connected',
                        style: TextStyle(
                            color: user.isDisconnected ? Colors.red : user.isTerminated ? Colors.orange : Colors.green,
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

class RecentSubscriptionsView extends StatefulWidget {
    final List<UserData> userDataList;

    const RecentSubscriptionsView({super.key, required this.userDataList});

    @override
    _RecentSubscriptionsViewState createState() => _RecentSubscriptionsViewState();
}

class _RecentSubscriptionsViewState extends State<RecentSubscriptionsView> {
    late Future<List<UserData>> _futureUserData;
    late UserDataDataSource _dataSource;

    @override
    void initState() {
        super.initState();
        // Call parseUserData() to load and parse data
        _futureUserData = parseUserData();
    }

    // Function to filter users based on connection date/created date
    List<UserData> filterRecentUsers(List<UserData> users) {
        final currentDate = DateTime.now();
        final cutoffDate = currentDate.subtract(Duration(days: 30));

        // Filter users based on the condition (createdAt within the last 30 days)
        return users.where((user) {
            final connectionDate = user.createdAt; // Use createdAt or lastConnectionTime
            return connectionDate.isAfter(cutoffDate) && connectionDate.isBefore(currentDate);
        }).take(15).toList(); // Take the first 15 filtered users
    }

    @override
    Widget build(BuildContext context) {
        return FutureBuilder<List<UserData>>(
            future: _futureUserData,
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display loading indicator while waiting for data
                    return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                    // Display error message if an error occurs
                    return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                    // Data is loaded successfully
                    final users = snapshot.data!;
                    
                    // Filter the users based on connection date/created date
                    final filteredUsers = filterRecentUsers(users);

                    // Create a data source for the data table
                    _dataSource = UserDataDataSource(filteredUsers);

                    // Display the data table within a container that fills the available width
                    return Container(
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
                    );
                }
            },
        );
    }
}
