import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/neumorphic.dart'; // Import the FlatNeumorphismDesign widget
import '../theme_provider.dart'; // Import the theme provider

class CustomPagination extends StatelessWidget {
  final int totalPage;
  final int currentPage;
  final ValueChanged<int> onPageChange;
  final int show;
  final double fontSize;

  const CustomPagination({
    super.key,
    required this.totalPage,
    required this.currentPage,
    required this.onPageChange,
    this.show = 4,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    List<Widget> paginationItems = [];

    // Add previous page button
    if (currentPage > 0) {
      paginationItems.add(_buildArrowButton(Icons.keyboard_arrow_left, currentPage - 1, isDarkMode));
    }

    int startPage = (currentPage - show ~/ 2).clamp(0, totalPage - show);
    int endPage = (startPage + show).clamp(0, totalPage);

    if (startPage > 0) {
      paginationItems.add(_buildPageItem(0, context, isDarkMode));
      paginationItems.add(const Text('...'));
    }

    for (int i = startPage; i < endPage; i++) {
      paginationItems.add(_buildPageItem(i, context, isDarkMode));
    }

    if (endPage < totalPage) {
      paginationItems.add(const Text('...'));
      paginationItems.add(_buildPageItem(totalPage - 1, context, isDarkMode));
    }

    // Add next page button
    if (currentPage < totalPage - 1) {
      paginationItems.add(_buildArrowButton(Icons.keyboard_arrow_right, currentPage + 1, isDarkMode));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: paginationItems.map((widget) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: isDarkMode
              ? DarkFlatNeumorphismDesign(child: widget)
              : FlatNeumorphismDesign(child: widget),
        );
      }).toList(),
    );
  }

  Widget _buildArrowButton(IconData icon, int pageIndex, bool isDarkMode) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onPageChange(pageIndex),
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF403943) : Colors.grey[200],
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Icon(
              icon,
              color: isDarkMode ? Colors.white : Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageItem(int pageIndex, BuildContext context, bool isDarkMode) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onPageChange(pageIndex),
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: pageIndex == currentPage
                ? (isDarkMode ? const Color(0xFF403943) : Colors.blueGrey[100])
                : (isDarkMode ? const Color(0xFF2E2E2E) : Colors.grey[200]),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Text(
              '${pageIndex + 1}',
              style: TextStyle(
                fontSize: fontSize,
                color: pageIndex == currentPage
                    ? Colors.white
                    : (isDarkMode ? Colors.grey[200] : Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
