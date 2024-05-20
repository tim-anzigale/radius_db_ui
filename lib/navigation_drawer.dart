import 'package:flutter/material.dart';
import './Pages/settings.dart'; // Import your settings page
import './components/neumorphic.dart'; // Import the file containing FlatNeumorphismDesign

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String _selectedTile = '';

  void _onTileSelected(String title) {
    setState(() {
      _selectedTile = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildDrawerHeader(),
                _buildDrawerTile(
                  icon: Icons.home,
                  text: 'Dashboard',
                  isSelected: _selectedTile == 'Dashboard',
                  onTap: () {
                    _onTileSelected('Dashboard');
                    Navigator.pop(context); // Close the drawer
                    // Navigate to the home screen
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                _buildDrawerTile(
                  icon: Icons.person,
                  text: 'Subscriptions',
                  isSelected: _selectedTile == 'Subscriptions',
                  onTap: () {
                    _onTileSelected('Subscriptions');
                    Navigator.pop(context); // Close the drawer
                    // Navigate to the subscriptions page
                    Navigator.pushReplacementNamed(context, '/subscriptions');
                  },
                ),
                _buildDrawerTile(
                  icon: Icons.settings,
                  text: 'Settings',
                  isSelected: _selectedTile == 'Settings',
                  onTap: () {
                    _onTileSelected('Settings');
                    Navigator.pop(context); // Close the drawer
                    // Navigate to the settings page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                  },
                ),
              ],
            ),
          ),
          // Profile tile
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://example.com/your-profile-picture.jpg'),
              ),
              title: const Text(
                'Tim',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: const Text(
                'System Admin',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              trailing: const Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // Handle profile tile tap
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Darker base color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.computer, color: Colors.grey[900]),
          const SizedBox(width: 10),
          Text(
            'Radius',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile({
    required IconData icon,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Material(
        color: isSelected ? Colors.blueGrey[100] : Colors.transparent,
        elevation: isSelected ? 2 : 0,
        borderRadius: BorderRadius.circular(10),
        child: _HoverableListTile(
          icon: icon,
          text: text,
          isSelected: isSelected,
          onTap: onTap,
          hoverColor: const Color(0xFF403943),
        ),
      ),
    );
  }
}

class _HoverableListTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final Color hoverColor;

  const _HoverableListTile({
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.hoverColor,
  });

  @override
  _HoverableListTileState createState() => _HoverableListTileState();
}

class _HoverableListTileState extends State<_HoverableListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color? textColor = _isHovered ? Colors.white : (widget.isSelected ? Colors.blueGrey[800] : Colors.grey[800]);
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: _isHovered ? widget.hoverColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(widget.icon, color: textColor),
            title: Text(
              widget.text,
              style: TextStyle(
                color: textColor,
                fontSize: 12, // Adjusted font size
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: textColor),
          ),
        ),
      ),
    );
  }
}
