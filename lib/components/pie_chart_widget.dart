import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../user_data.dart';

class PieChartWidget extends StatelessWidget {
  final List<UserData> userDataList;

  const PieChartWidget({Key? key, required this.userDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int connectedCount = userDataList.where((user) => !user.isDisconnected && !user.isTerminated).length;
    int disconnectedCount = userDataList.where((user) => user.isDisconnected).length;
    int terminatedCount = userDataList.where((user) => user.isTerminated).length;

    print('Connected: $connectedCount, Disconnected: $disconnectedCount, Terminated: $terminatedCount'); // Debug print

    if (userDataList.isEmpty) {
      return Center(child: Text('No data available'));
    }

    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: connectedCount.toDouble(),
            title: 'Connected\n$connectedCount',
            radius: 50,
            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: disconnectedCount.toDouble(),
            title: 'Disconnected\n$disconnectedCount',
            radius: 50,
            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.grey,
            value: terminatedCount.toDouble(),
            title: 'Terminated\n$terminatedCount',
            radius: 50,
            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }
}
