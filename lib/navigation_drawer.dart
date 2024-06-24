import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class SideMenu extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SideMenu({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String? _hoveredTile;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final menuColor = isDarkMode ? const Color(0xFF2E2E2E) : Colors.grey[200];

    return Stack(
      children: [
        Container(
          width: 80, // Set the width of the side menu
          decoration: BoxDecoration(
            color: menuColor,
          ),
          child: Column(
            children: [
              _buildDrawerHeader(isDarkMode),
              _buildDrawerTile(
                context: context,
                icon: Icons.home,
                text: 'Dashboard',
                index: 0,
                isDarkMode: isDarkMode,
                isHovered: _hoveredTile == 'Dashboard',
              ),
              _buildDrawerTile(
                context: context,
                icon: Icons.person,
                text: 'Subscriptions',
                index: 1,
                isDarkMode: isDarkMode,
                isHovered: _hoveredTile == 'Subscriptions',
              ),
              _buildDrawerTile(
                context: context,
                icon: Icons.people,
                text: 'Users',
                index: 2,
                isDarkMode: isDarkMode,
                isHovered: _hoveredTile == 'Users',
              ),
              _buildDrawerTile(
                context: context,
                icon: Icons.list,
                text: 'Plans',
                index: 3,
                isDarkMode: isDarkMode,
                isHovered: _hoveredTile == 'Plans',
              ),
              _buildDrawerTile(
                context: context,
                icon: Icons.alt_route,
                text: 'Poles',
                index: 4,
                isDarkMode: isDarkMode,
                isHovered: _hoveredTile == 'Poles',
              ),
              _buildDrawerTile(
                context: context,
                icon: Icons.settings,
                text: 'Settings',
                index: 5,
                isDarkMode: isDarkMode,
                isHovered: _hoveredTile == 'Settings',
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildDrawerTile(
            context: context,
            icon: Icons.account_circle,
            text: 'Profile',
            index: 6,
            isDarkMode: isDarkMode,
            isHovered: _hoveredTile == 'Profile',
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerHeader(bool isDarkMode) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2E2E2E) : Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.computer, color: isDarkMode ? Colors.grey[200] : Colors.grey[900]),
          const SizedBox(height: 10),
          Text(
            'Radius',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[200] : Colors.grey[900],
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile({
    required BuildContext context,
    required IconData icon,
    required String text,
    required int index,
    required bool isDarkMode,
    required bool isHovered,
  }) {
    final isSelected = widget.selectedIndex == index;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoveredTile = text;
        });
      },
      onExit: (_) {
        setState(() {
          _hoveredTile = null;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.onItemSelected(index);
        },
        child: Container(
          width: 80, // Ensure it touches the edges
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDarkMode ? Colors.blueGrey[800] : Colors.blueGrey[100])
                : (isHovered
                    ? (isDarkMode ? const Color(0xFF403943) : const Color(0xFFE0E0E0))
                    : Colors.transparent),
          ),
          child: Column(
            children: [
              Icon(icon, color: isDarkMode ? Colors.grey[200] : Colors.grey[900]),
              const SizedBox(height: 2),
              Text(
                text,
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[200] : Colors.grey[900],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
