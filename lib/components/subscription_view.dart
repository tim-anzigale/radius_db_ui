import 'package:flutter/material.dart';
import 'package:radius_db_ui/header.dart';
import '../data/data_service.dart'; 
import '../user_data.dart'; 


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
                DataCell(Text(user.planName)),
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

class SubscriptionsView extends StatefulWidget {
    const SubscriptionsView({super.key});

    @override
    _SubscriptionsViewState createState() => _SubscriptionsViewState();
}

class _SubscriptionsViewState extends State<SubscriptionsView> {
    late Future<List<UserData>> _futureUserData;
    late UserDataDataSource _dataSource;

    @override
    void initState() {
        super.initState();
        // Call parseUserData() to load and parse data
        _futureUserData = parseUserData();
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
                    // Create a data source for the paginated data table
                    _dataSource = UserDataDataSource(users);

                    // Display the paginated data table within a container that fills the available width
                   return SizedBox(
    width: double.infinity,
    child: PaginatedDataTable(
        columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('IP')),
            DataColumn(label: Text('MAC')),
            DataColumn(label: Text('Plan')),
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
