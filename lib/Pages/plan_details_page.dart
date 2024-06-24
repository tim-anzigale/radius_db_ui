import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/plan_class.dart';
import '../components/neumorphic.dart';

class PlanDetailsPage extends StatelessWidget {
  final Plan plan;

  const PlanDetailsPage({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isDarkMode
              ? DarkFlatNeumorphismDesign(
                  child: _buildPlanDetailsContent(),
                )
              : FlatNeumorphismDesign(
                  child: _buildPlanDetailsContent(),
                ),
        ),
      ),
    );
  }

  Widget _buildPlanDetailsContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adjust padding as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Name', plan.name),
          _buildDetailRow('Limit', plan.limitStr),
          _buildDetailRow('Created At', plan.createdAt.toLocal().toString()),
          _buildDetailRow('Updated At', plan.updatedAt.toLocal().toString()),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
