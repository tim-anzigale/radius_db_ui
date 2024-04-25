import 'package:flutter/material.dart';
import 'user_data.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserData>>(
      future: parseUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading indicator
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error handling
        } else {
          final userDataList = snapshot.data!;

          return Container(
            // Add margin around the Container
            margin: EdgeInsets.all(10.0), // Add margin from all sides
            // Apply decoration to the Container to achieve the rounded border
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the Container
              borderRadius: BorderRadius.circular(15.0), // Set rounded corners
              border: Border.all(
                color: Colors.grey, // Border color
                width: 1.0, // Border width
              ),
            ),
            child: Column(
              children: [
                // Header for the ListView
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Define the headers for each column
                      Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'IP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Plan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // ListView.builder for displaying user data
                Expanded(
                  child: ListView.builder(
                    itemCount: userDataList.length,
                    itemBuilder: (context, index) {
                      final userData = userDataList[index];
                      return ListTile(
                        title: Text(userData.name),
                        subtitle: Text('IP: ${userData.ip}\nPlan: ${userData.planName}'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Disconnected: ${userData.isDisconnected}'),
                            Text('Terminated: ${userData.isTerminated}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
