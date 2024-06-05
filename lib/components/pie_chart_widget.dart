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

    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: connectedCount.toDouble(),
            title: 'Connected\n$connectedCount',
            radius: 50,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: disconnectedCount.toDouble(),
            title: 'Disconnected\n$disconnectedCount',
            radius: 50,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.grey,
            value: terminatedCount.toDouble(),
            title: 'Terminated\n$terminatedCount',
            radius: 50,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }
}
