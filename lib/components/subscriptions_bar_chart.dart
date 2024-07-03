import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../models/subscription_class.dart';

class SubscriptionsBarChart extends StatelessWidget {
  final List<Subscription> subscriptions;

  const SubscriptionsBarChart({super.key, required this.subscriptions});

  @override
  Widget build(BuildContext context) {
    // Group subscriptions by month and count connected/disconnected
    final Map<String, Map<String, int>> groupedByMonth = groupAndCountSubscriptionsByMonth(subscriptions);

    // Create BarChartGroupData for each month
    List<BarChartGroupData> barChartGroups = createBarChartGroups(groupedByMonth);

    return BarChart(
      BarChartData(
        barGroups: barChartGroups,
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, interval: 5),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => bottomTitles(value, meta, groupedByMonth.keys.toList()),
            ),
          ),
        ),
        barTouchData: BarTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }

  // Group subscriptions by month and count connected/disconnected
  Map<String, Map<String, int>> groupAndCountSubscriptionsByMonth(List<Subscription> subscriptions) {
    final Map<String, Map<String, int>> groupedByMonth = {};
    for (var subscription in subscriptions) {
      final DateTime start = subscription.createdAt;
      final DateTime end = DateTime.now();
      DateTime current = DateTime(start.year, start.month);

      while (current.isBefore(end)) {
        final String month = DateFormat('yyyy-MM').format(current);
        if (!groupedByMonth.containsKey(month)) {
          groupedByMonth[month] = {'connected': 0, 'disconnected': 0};
        }
        if (subscription.createdAt.isBefore(current.add(const Duration(days: 30)))) {
          if (!subscription.isDisconnected && !subscription.isTerminated) {
            groupedByMonth[month]!['connected'] = groupedByMonth[month]!['connected']! + 1;
          } else if (subscription.isDisconnected && !subscription.isTerminated) {
            groupedByMonth[month]!['disconnected'] = groupedByMonth[month]!['disconnected']! + 1;
          }
        }
        current = DateTime(current.year, current.month + 1);
      }
    }
    return groupedByMonth;
  }

  // Create BarChartGroupData for each month
  List<BarChartGroupData> createBarChartGroups(Map<String, Map<String, int>> groupedByMonth) {
    int index = 0;
    return groupedByMonth.entries.map((entry) {
      final String month = entry.key;
      final int connected = entry.value['connected']!;
      final int disconnected = entry.value['disconnected']!;
      return createBarChartGroup(index++, connected.toDouble(), disconnected.toDouble(), month);
    }).toList();
  }

  // Create BarChartGroupData for connected and disconnected subscriptions
  BarChartGroupData createBarChartGroup(int x, double y1, double y2, String month) {
    return BarChartGroupData(
      x: x,
      barsSpace: 4,
      barRods: [
        BarChartRodData(toY: y1, color: Colors.green, width: 10, borderRadius: BorderRadius.zero),
        BarChartRodData(toY: y2, color: Colors.red, width: 10, borderRadius: BorderRadius.zero),
      ],
    );
  }

  // Widget to display bottom titles for the chart
  Widget bottomTitles(double value, TitleMeta meta, List<String> months) {
    final String month = months[value.toInt()];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        month,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
