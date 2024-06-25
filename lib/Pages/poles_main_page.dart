import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/neumorphic.dart';
import '../theme_provider.dart'; // Import the theme provider

class PolesMainPage extends StatelessWidget {
  final Function(int) onCardTapped;

  const PolesMainPage({Key? key, required this.onCardTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the scaffold background color to white
      appBar: AppBar(
        title: const Text('Poles'),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildGridSection(context),
          ],
        ),
      ),
    );
  }

  // Helper function to build the grid section
  Widget _buildGridSection(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width >= 800;
    final int crossAxisCount = isWideScreen ? 2 : 1;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: 1.5, // Adjust this value to reduce the height of the grid items
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 16.0,
      children: [
        _buildNeumorphismContainer(
          context,
          'All Poles',
          () => onCardTapped(1), // 1 for All Poles
        ),
        _buildNeumorphismContainer(
          context,
          'Pole Paths',
          () => onCardTapped(2), // 2 for Pole Paths
        ),
      ],
    );
  }

  // Helper function to build the Neumorphism container.
  Widget _buildNeumorphismContainer(BuildContext context, String title, VoidCallback onTap) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return GestureDetector(
      onTap: onTap,
      child: isDarkMode
          ? DarkFlatNeumorphismDesign(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          : FlatNeumorphismDesign(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
    );
  }
}
