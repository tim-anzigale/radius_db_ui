import 'package:flutter/material.dart';
import 'user_data.dart';
import 'components/user_stats.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserData>>(
      future: parseUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userDataList = snapshot.data!;
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  NeumorphicContainer(
                    child: UserStats(userDataList: userDataList),
                  ),
                  const SizedBox(height: 10),
                  NeumorphicContainer(
                    child: ResponsiveTable(userDataList: userDataList),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class NeumorphicContainer extends StatelessWidget {
  final Widget child;

  const NeumorphicContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}




// Assuming NeumorphicContainer is defined similarly as before

class ResponsiveTable extends StatelessWidget {
  final List<UserData> userDataList;

  const ResponsiveTable({super.key, required this.userDataList});

  @override
  Widget build(BuildContext context) {
    final userDataSource = UserDataSource(userDataList);
    final screenWidth = MediaQuery.of(context).size.width;
    int rowsPerPage = screenWidth > 800 ? 20 : 10;

    return PaginatedDataTable(
      header: const Text('Subscriptions', textAlign: TextAlign.left),
      columns: const [
        DataColumn(label: Text('Name', textAlign: TextAlign.center)),
        DataColumn(label: Text('IP', textAlign: TextAlign.center)),
        DataColumn(label: Text('NAS', textAlign: TextAlign.center)),
        DataColumn(label: Text('MAC', textAlign: TextAlign.center)),
        DataColumn(label: Text('Plan', textAlign: TextAlign.center)),
        DataColumn(label: Text('Status', textAlign: TextAlign.center)),
      ],
      source: userDataSource,
      rowsPerPage: rowsPerPage,
      showFirstLastButtons: true,
    );
  }
}

class UserDataSource extends DataTableSource {
  final List<UserData> userDataList;

  UserDataSource(this.userDataList);

  @override
  DataRow? getRow(int index) {
    if (index >= userDataList.length) return null;
    final userData = userDataList[index];
    return DataRow(cells: [
      DataCell(Text(userData.name)),
      DataCell(Text(userData.ip)),
      DataCell(Text(userData.nas)),
      DataCell(Text(userData.macAdd)),
      DataCell(Text(userData.planName)),
      DataCell(Text(userData.isDisconnected ? 'Disconnected' : userData.isTerminated ? 'Terminated' : 'Connected',
          style: TextStyle(color: userData.isDisconnected ? Colors.red : userData.isTerminated ? Colors.orange : Colors.green))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => userDataList.length;
  @override
  int get selectedRowCount => 0;
}
