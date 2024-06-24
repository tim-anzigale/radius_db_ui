import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:radius_db_ui/models/subscription_class.dart';
import '../services/api_service.dart'; // Import your API service

class PieChartWidget extends StatefulWidget {
  final List<Subscription> subscriptions;

  const PieChartWidget({super.key, required this.subscriptions});

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  late List<Subscription> _subscriptions;

  @override
  void initState() {
    super.initState();
    _subscriptions = widget.subscriptions;
  }

  Future<void> _refreshData() async {
    List<Subscription> newData = await fetchSubscriptions();
    setState(() {
      _subscriptions = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    int connectedCount = _subscriptions.where((subscription) => !subscription.isDisconnected && !subscription.isTerminated).length;
    int disconnectedCount = _subscriptions.where((subscription) => subscription.isDisconnected).length;
    int terminatedCount = _subscriptions.where((subscription) => subscription.isTerminated).length;

    /**if (kDebugMode) {
      print('Subscriptions Length: ${_subscriptions.length}');
    }
    print('Connected: $connectedCount, Disconnected: $disconnectedCount, Terminated: $terminatedCount');**/

    if (_subscriptions.isEmpty) {
      return const Center(child: Text('No data available'));
    }

   /** _subscriptions.forEach((subscription) {
      print('Subscription: ${subscription.name}, IP: ${subscription.lastCon.ip}, Plan: ${subscription.plan.name}');
    });**/

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0), // Add padding to the title
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subscription Status',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _refreshData,
                tooltip: 'Refresh',
              ),
            ],
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
