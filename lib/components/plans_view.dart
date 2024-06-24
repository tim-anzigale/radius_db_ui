import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/plan_class.dart';

class PlansView extends StatelessWidget {
  final List<Plan> plans;
  final void Function(Plan) onPlanSelected;

  const PlansView({Key? key, required this.plans, required this.onPlanSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double columnSpacing = screenWidth * 0.02; // Adjust spacing between columns based on screen width

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Plans',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: screenWidth),
            child: DataTable(
              showCheckboxColumn: false, // Remove the checkbox column
              columnSpacing: columnSpacing,
              columns: [
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(color: Colors.grey), // Grey color for header text
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Limit',
                    style: TextStyle(color: Colors.grey), // Grey color for header text
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Created At',
                    style: TextStyle(color: Colors.grey), // Grey color for header text
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Updated At',
                    style: TextStyle(color: Colors.grey), // Grey color for header text
                  ),
                ),
              ],
              rows: plans.map((plan) {
                return DataRow(
                  cells: [
                    DataCell(Text(plan.name)),
                    DataCell(Text(plan.limitStr)),
                    DataCell(Text(plan.createdAt.toLocal().toString())),
                    DataCell(Text(plan.updatedAt.toLocal().toString())),
                  ],
                  onSelectChanged: (_) => onPlanSelected(plan), // Make the entire row clickable
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
