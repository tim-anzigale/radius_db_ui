import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_app_bar.dart';
import '../theme_provider.dart';
import '../models/users_class.dart';
import '../components/neumorphic.dart';
import '../components/users_view.dart';
import '../services/api_service.dart'; // Import your API service


class UsersPage extends StatefulWidget {
  final DateTime? lastSyncedTime;
  final String syncStatus;

  const UsersPage({
    super.key,
    this.lastSyncedTime,
    this.syncStatus = "Not synced yet",
  });

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Users',
        lastSyncedTime: widget.lastSyncedTime,
        syncStatus: widget.syncStatus,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder<List<User>>(
          future: _futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error fetching users: ${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0), // Add padding to ensure it does not touch the screen edges
                child: Center(
                  child: isDarkMode
                      ? DarkFlatNeumorphismDesign(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: UsersView(users: users),
                          ),
                        )
                      : FlatNeumorphismDesign(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: UsersView(users: users),
                          ),
                        ),
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
