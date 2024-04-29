import 'package:flutter/material.dart';
import 'user_data.dart';
import 'user_stats.dart';

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
          return LayoutBuilder(
            builder: (context, constraints) {
              final userDataList = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    UserStats(userDataList: userDataList),
                    ResponsiveTable(userDataList: userDataList),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}

class ResponsiveTable extends StatelessWidget {
  final List<UserData> userDataList;

  const ResponsiveTable({Key? key, required this.userDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: PaginatedDataTable(
        header: const Text('Subscriptions'),
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('IP')),
          DataColumn(label: Text('NAS')),
          DataColumn(label: Text('MAC')),
          DataColumn(label: Text('Plan')),
          DataColumn(label: Text('Status')),
        ],
        source: UserDataDataSource(userDataList),
        rowsPerPage: _rowsPerPage(context),
        columnSpacing: _columnSpacing(context),
        horizontalMargin: _horizontalMargin(context),
      ),
    );
  }

  int _rowsPerPage(BuildContext context) {
    if (MediaQuery.of(context).size.width > 800) {
      return 20;
    }
    return 10;
  }

  double _columnSpacing(BuildContext context) {
    if (MediaQuery.of(context).size.width > 800) {
      return 50;
    }
    return 20;
  }

  double _horizontalMargin(BuildContext context) {
    if (MediaQuery.of(context).size.width > 800) {
      return 20;
    }
    return 10;
  }
}

class UserDataDataSource extends DataTableSource {
  final List<UserData> userDataList;

  UserDataDataSource(this.userDataList);

  @override
  DataRow? getRow(int index) {
    if (index >= userDataList.length) {
      return null;
    }
    final userData = userDataList[index];
    return DataRow(
      cells: [
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
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userDataList.length;

  @override
  int get selectedRowCount => 0;
}
