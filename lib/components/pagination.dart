// pagination.dart

import 'package:flutter/material.dart';
import '../components/neumorphic.dart'; // Import the FlatNeumorphismDesign widget

class CustomPagination extends StatelessWidget {
  final int totalPage;
  final int currentPage;
  final ValueChanged<int> onPageChange;
  final int show;
  final double fontSize; // Add fontSize parameter

  const CustomPagination({
    super.key,
    required this.totalPage,
    required this.currentPage,
    required this.onPageChange,
    this.show = 4,
    this.fontSize = 14.0, // Default font size
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> paginationItems = [];
    int startPage = (currentPage - show ~/ 2).clamp(0, totalPage - show);
    int endPage = (startPage + show).clamp(0, totalPage);

    if (startPage > 0) {
      paginationItems.add(_buildPageItem(0, context));
      paginationItems.add(const Text('...'));
    }

    for (int i = startPage; i < endPage; i++) {
      paginationItems.add(_buildPageItem(i, context));
    }

    if (endPage < totalPage) {
      paginationItems.add(const Text('...'));
      paginationItems.add(_buildPageItem(totalPage - 1, context));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: paginationItems.map((widget) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: FlatNeumorphismDesign(
            child: widget,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPageItem(int pageIndex, BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onPageChange(pageIndex),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: pageIndex == currentPage ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '${pageIndex + 1}',
            style: TextStyle(
              fontSize: fontSize,
              color: pageIndex == currentPage ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
