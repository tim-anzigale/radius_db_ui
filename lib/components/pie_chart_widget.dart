import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../user_data.dart';

class PieChartWidget extends StatelessWidget {
  final List<UserData> userDataList;

  const PieChartWidget({super.key, required this.userDataList});

  @override
  Widget build(BuildContext context) {
    int connectedCount = userDataList.where((userData) => !userData.isDisconnected && !userData.isTerminated).length;
    int disconnectedCount = userDataList.where((userData) => userData.isDisconnected).length;
    int terminatedCount = userDataList.where((userData) => userData.isTerminated).length;

    if (kDebugMode) {
      print('UserDataList Length: ${userDataList.length}');
    }
    print('Connected: $connectedCount, Disconnected: $disconnectedCount, Terminated: $terminatedCount');

    if (userDataList.isEmpty) {
      return const Center(child: Text(''));
    }

    userDataList.forEach((userData) {
      print('User: ${userData.name}, IP: ${userData.ip}, Plan: ${userData.planName}');
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

