import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/subscription_class.dart';

class SubscriptionsBarChart extends StatelessWidget {
  final List<Subscription> subscriptions;

  const SubscriptionsBarChart({super.key, required this.subscriptions});

  @override
  Widget build(BuildContext context) {
    // Calculate the number of connected and disconnected subscriptions
    int connectedSubscriptions = countConnected(subscriptions);
    int disconnectedSubscriptions = countDisconnected(subscriptions);

    // Create a list of BarChartGroupData
    List<BarChartGroupData> barChartGroups = [
      createBarChartGroup(0, connectedSubscriptions.toDouble(), disconnectedSubscriptions.toDouble()),
    ];

    return BarChart(
      BarChartData(
        barGroups: barChartGroups,
        titlesData: FlTitlesData(
          show: true,
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, interval: 5),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
            ),
          ),
        ),
        barTouchData: BarTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
      ),
    );
  }

  // Calculate the number of connected subscriptions
  int countConnected(List<Subscription> subscriptions) {
    return subscriptions.where((subscription) => !subscription.isDisconnected).length;
  }

  // Calculate the number of disconnected subscriptions
  int countDisconnected(List<Subscription> subscriptions) {
    return subscriptions.where((subscription) => subscription.isDisconnected).length;
  }

  // Create BarChartGroupData for connected and disconnected subscriptions
  BarChartGroupData createBarChartGroup(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barsSpace: 4,
      barRods: [
        BarChartRodData(toY: y1, color: Colors.green, width: 10),
        BarChartRodData(toY: y2, color: Colors.red, width: 10),
      ],
    );
  }

  // Widget to display bottom titles for the chart
  Widget bottomTitles(double value, TitleMeta meta) {
    final List<String> labels = ['Connected', 'Disconnected'];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        labels[value.toInt()],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
