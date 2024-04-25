// lib/user_list_view.dart

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
          return ListView.builder(
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
          );
        }
      },
    );
  }
}
