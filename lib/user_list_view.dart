import 'package:flutter/material.dart';
import 'user_data.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserData>>( //asynchronous fetching of user data
      future: parseUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Loading indicator
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error handling
        } else {
          final userDataList = snapshot.data!;
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('IP')),
                        DataColumn(label: Text('NAS')),
                        DataColumn(label: Text('MAC')),
                        DataColumn(label: Text('Plan')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: userDataList.map((userData) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text(userData.name)),
                            DataCell(Text(userData.ip)),
                            DataCell(Text(userData.nas)),
                            DataCell(Text(userData.macAdd)),
                            DataCell(Text(userData.planName)),
                            DataCell(
                              Text(
                                userData.isDisconnected
                                    ? 'Disconnected'
                                    : userData.isTerminated
                                        ? 'Terminated'
                                        : 'Connected',
                                style: TextStyle(
                                  color: userData.isDisconnected
                                      ? Colors.red
                                      : userData.isTerminated
                                          ? Colors.orange
                                          : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
