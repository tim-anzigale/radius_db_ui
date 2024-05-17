import 'package:flutter/material.dart';

class Filters {
  static const List<String> filterOptions = ['Newest', 'Terminated', 'Active'];

  static Widget buildFilterDropdown(
    String? selectedFilter, 
    void Function(String?) onChanged, 
    {required double width, required double fontSize}
  ) {
    return SizedBox(
      width: width, // Set the width of the dropdown
      child: DropdownButton<String>(
        value: selectedFilter,
        onChanged: onChanged,
        items: filterOptions.map((String filter) {
          return DropdownMenuItem<String>(
            value: filter,
            child: Text(
              filter,
              style: TextStyle(fontSize: fontSize), // Set the font size
            ),
          );
        }).toList(),
      ),
    );
  }
}
