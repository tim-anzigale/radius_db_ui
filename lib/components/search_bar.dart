import 'package:flutter/material.dart';
import 'package:radius_db_ui/components/filters.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final String? selectedFilter;
  final ValueChanged<String?> onFilterChanged;
  final double filterWidth;
  final double fontSize;

  const SearchBar({
    super.key,
    required this.searchController,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.filterWidth,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double searchBarWidth = screenWidth > 600 ? 400 : 250;

    return SizedBox(
      height: 40,
      width: searchBarWidth,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                // Update state in the parent widget
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Filters.buildFilterDropdown(
            selectedFilter,
            onFilterChanged,
            width: filterWidth, // Pass adjusted width
            fontSize: fontSize, // Pass adjusted font size
          ),
        ],
      ),
    );
  }
}
