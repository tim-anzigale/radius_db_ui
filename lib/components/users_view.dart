import 'package:flutter/material.dart';
import '../models/users_class.dart'; // Adjust the import path as per your project structure

class UsersView extends StatelessWidget {
  final List<User> users; // Assuming users is passed to this widget

  const UsersView({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int columnCount = 5; // Number of columns in the DataTable
    final double columnWidth = screenWidth / columnCount;

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
              columnSpacing: 0, // Set to 0 to ensure columns are equally spaced
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
                    child: const Text('Permission', style: TextStyle(color: Colors.grey)),
                  ),
                ),
              ],
              rows: users.map((user) {
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
