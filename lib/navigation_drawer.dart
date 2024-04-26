// lib/navigation_drawer.dart

import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 97, 175, 239),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Menu options in the drawer
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              // Handle navigation to home screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Subscriptions'),
            onTap: () {
              // Handle navigation to profile screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle navigation to settings screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
            },
          ),
          // Add more menu options as needed
        ],
      ),
    );
  }
}
