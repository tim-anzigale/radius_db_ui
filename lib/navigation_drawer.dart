import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Pages/settings.dart'; // Import your settings page
import './components/neumorphic.dart'; // Import the file containing FlatNeumorphismDesign
import './theme_provider.dart'; // Import the theme provider

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildDrawerHeader(isDarkMode),
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
                  isDarkMode: isDarkMode,
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
                  isDarkMode: isDarkMode,
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
                  isDarkMode: isDarkMode,
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
              title: Text(
                'Tim',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[200] : Colors.grey[900], // Text color based on theme
                ),
              ),
              subtitle: Text(
                'System Admin',
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey, // Subtitle color based on theme
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_down, color: isDarkMode ? Colors.grey[200] : Colors.grey[900]),
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

  Widget _buildDrawerHeader(bool isDarkMode) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2E2E2E) : Colors.grey[200], // Background color based on theme
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.computer, color: isDarkMode ? Colors.grey[200] : Colors.grey[900]),
          const SizedBox(width: 10),
          Text(
            'Radius',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[200] : Colors.grey[900],
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
    required bool isDarkMode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Material(
        color: isSelected ? (isDarkMode ? Colors.blueGrey[800] : Colors.blueGrey[100]) : Colors.transparent,
        elevation: isSelected ? 2 : 0,
        borderRadius: BorderRadius.circular(10),
        child: _HoverableListTile(
          icon: icon,
          text: text,
          isSelected: isSelected,
          onTap: onTap, //const Color(0xFFE0E0E0)
          hoverColor: isDarkMode ? const Color(0xFF403943) :  const Color(0xFF403943),
          isDarkMode: isDarkMode,
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
  final bool isDarkMode;

  const _HoverableListTile({
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.hoverColor,
    required this.isDarkMode,
  });

  @override
  _HoverableListTileState createState() => _HoverableListTileState();
}

class _HoverableListTileState extends State<_HoverableListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color? textColor = _isHovered ? Colors.white : (widget.isSelected ? Colors.blueGrey[800] : (widget.isDarkMode ? Colors.grey[200] : Colors.grey[800]));
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
                fontSize: 13, // Adjusted font size
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: textColor),
          ),
        ),
      ),
    );
  }
}
