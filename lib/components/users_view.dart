import 'package:flutter/material.dart';
import '../models/users_class.dart'; 

class UsersView extends StatefulWidget {
  final List<User> users; 

  const UsersView({Key? key, required this.users}) : super(key: key);

  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  bool _sortAscending = true;
  int _sortColumnIndex = 4; // Index of the "Permission" column

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int columnCount = 5; // Number of columns in the DataTable
    final double columnWidth = screenWidth / columnCount;

    // Copy the users list to perform sorting
    List<User> sortedUsers = List.from(widget.users);

    // Sorting logic based on _sortColumnIndex and _sortAscending
    sortedUsers.sort((a, b) {
      if (_sortColumnIndex == 4) {
        // Sort by permission (profile)
        return _sortAscending
            ? a.profile.toLowerCase().compareTo(b.profile.toLowerCase())
            : b.profile.toLowerCase().compareTo(a.profile.toLowerCase());
      }
      return 0; // Default to no sorting
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Users',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: screenWidth),
            child: DataTable(
              columnSpacing: 0, 
              columns: [
                DataColumn(
                  label: Container(
                    width: columnWidth,
                    child: const Text('Username', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: columnWidth,
                    child: const Text('Email', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: columnWidth,
                    child: const Text('Phone', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: columnWidth,
                    child: const Text('Role', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: columnWidth,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _sortColumnIndex = 4; // Sort by "Permission" column
                          _sortAscending = !_sortAscending; // Toggle ascending/descending
                        });
                      },
                      child: Row(
                        children: [
                          const Text('Permission', style: TextStyle(color: Colors.grey)),
                          Icon(
                            _sortColumnIndex == 4
                                ? _sortAscending
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward
                                : Icons.arrow_downward,
                            size: 13,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              rows: sortedUsers.map((user) {
                return DataRow(cells: [
                  DataCell(
                    Container(
                      width: columnWidth,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 40,
                          ),
                          const SizedBox(width: 10),
                          Text(user.username), // Access username directly from User object
                        ],
                      ),
                    ),
                  ),
                  DataCell(Container(
                    width: columnWidth,
                    child: Text(user.email),
                  )), // Access email directly from User object
                  DataCell(Container(
                    width: columnWidth,
                    child: Text(user.phone),
                  )), // Access phone directly from User object
                  DataCell(Container(
                    width: columnWidth,
                    child: Text(user.admin ? 'Admin' : 'User'),
                  )), // Access admin directly from User object
                  DataCell(Container(
                    width: columnWidth,
                    child: Text(user.profile),
                  )), // Access profile directly from User object
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
