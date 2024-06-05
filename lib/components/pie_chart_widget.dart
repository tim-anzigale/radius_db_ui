import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:radius_db_ui/classes/subscription_class.dart';

class PieChartWidget extends StatelessWidget {
  final List<Subscription> subscriptions;

  const PieChartWidget({super.key, required this.subscriptions});

  @override
  Widget build(BuildContext context) {
    int connectedCount = subscriptions.where((subscription) => !subscription.isDisconnected && !subscription.isTerminated).length;
    int disconnectedCount = subscriptions.where((subscription) => subscription.isDisconnected).length;
    int terminatedCount = subscriptions.where((subscription) => subscription.isTerminated).length;

    if (kDebugMode) {
      print('Subscriptions Length: ${subscriptions.length}');
    }
    print('Connected: $connectedCount, Disconnected: $disconnectedCount, Terminated: $terminatedCount');

    if (subscriptions.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    subscriptions.forEach((subscription) {
      print('Subscription: ${subscription.name}, IP: ${subscription.lastCon.ip}, Plan: ${subscription.plan.name}');
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0), // Add padding to the title
          child: Text(
            'Subscription Status',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200, // Set a specific height for the pie chart
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.green,
                  value: connectedCount.toDouble(),
                  title: '$connectedCount',
                  radius: 50,
                  titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                PieChartSectionData(
                  color: Colors.red,
                  value: disconnectedCount.toDouble(),
                  title: '$disconnectedCount',
                  radius: 50,
                  titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                PieChartSectionData(
                  color: Colors.grey,
                  value: terminatedCount.toDouble(),
                  title: '$terminatedCount',
                  radius: 50,
                  titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(color: Colors.green, text: 'Connected'),
        const SizedBox(width: 16),
        _buildLegendItem(color: Colors.red, text: 'Disconnected'),
        const SizedBox(width: 16),
        _buildLegendItem(color: Colors.grey, text: 'Terminated'),
      ],
    );
  }

  Widget _buildLegendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
