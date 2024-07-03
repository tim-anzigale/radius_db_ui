import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:radius_db_ui/models/subscription_class.dart';
import '../services/api_service.dart'; // Import your API service

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({Key? key}) : super(key: key);

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  List<Subscription> _subscriptions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      Map<String, dynamic> result = await fetchSubscriptions(1, 3000); // Fetch all subscriptions
      List<Subscription> newData = result['subscriptions'];
      setState(() {
        _subscriptions = newData;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    int connectedCount = _subscriptions.where((subscription) => !subscription.isDisconnected && !subscription.isTerminated).length;
    int disconnectedCount = _subscriptions.where((subscription) => subscription.isDisconnected).length;
    int terminatedCount = _subscriptions.where((subscription) => subscription.isTerminated).length;

    if (_subscriptions.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
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
          height: 200,
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
