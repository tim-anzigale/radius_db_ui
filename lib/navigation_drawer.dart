import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 120,  // Set a fixed height for the header
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Neumorphic base color
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              'Radius',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Dashboard (Home) option
                    _buildNeumorphicTile(
                        icon: Icons.home,
                        text: 'Dashboard',
                        onTap: () {
                            Navigator.pop(context); // Close the drawer
                            // Navigate to the home screen
                            Navigator.pushReplacementNamed(context, '/home');
                        },
                    ),
                    // Subscriptions option
                    _buildNeumorphicTile(
                        icon: Icons.person,
                        text: 'Subscriptions',
                        onTap: () {
                            Navigator.pop(context); // Close the drawer
                            // Navigate to the subscriptions page
                            Navigator.pushReplacementNamed(context, '/subscriptions');
                        },
                    ),
                    // Settings option (you can add your own functionality here)
                    _buildNeumorphicTile(
                        icon: Icons.settings,
                        text: 'Settings',
                        onTap: () {
                            Navigator.pop(context); // Close the drawer
                            // Add navigation logic for Settings
                        },
                    ),
        ],
      ),
    );
  }

  Widget _buildNeumorphicTile({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(text, style: TextStyle(color: Colors.grey[800])),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      // Neumorphic effect adjustment for each list tile
      selectedTileColor: Colors.grey[300],
      selected: true,
      enableFeedback: true,
      hoverColor: Colors.grey[300],
    );
  }
}
