import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../user_data.dart';

class SubscriptionsChart extends StatelessWidget {
    final List<UserData> userDataList;

    const SubscriptionsChart({super.key, required this.userDataList});

    @override
    Widget build(BuildContext context) {
        // Group subscriptions by date and calculate connected and disconnected counts
        final Map<DateTime, Map<String, int>> dateCounts = {};

        for (var userData in userDataList) {
            final subscriptionDate = DateTime(userData.createdAt.year, userData.createdAt.month, userData.createdAt.day);
            if (!dateCounts.containsKey(subscriptionDate)) {
                dateCounts[subscriptionDate] = {'connected': 0, 'disconnected': 0};
            }

            if (userData.isDisconnected) {
                // Increment the disconnected count, ensuring it's not null
                dateCounts[subscriptionDate]!['disconnected'] = (dateCounts[subscriptionDate]!['disconnected'] ?? 0) + 1;
            } else {
                // Increment the connected count, ensuring it's not null
                dateCounts[subscriptionDate]!['connected'] = (dateCounts[subscriptionDate]!['connected'] ?? 0) + 1;
            }
        }

        // Convert the dateCounts map to a list of maps for the chart data
        final data = dateCounts.entries.map((entry) {
            return {
                'date': entry.key, // The date (domain)
                'connected': entry.value['connected'], // The connected count (measure)
                'disconnected': entry.value['disconnected'], // The disconnected count (measure)
            };
        }).toList();

        // Define the series for the chart
        final series = [
            charts.Series<Map<String, dynamic>, DateTime>(
                id: 'Connected',
                colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                domainFn: (entry, _) => entry['date'] as DateTime,
                measureFn: (entry, _) => entry['connected'] as int,
                data: data,
            ),
            charts.Series<Map<String, dynamic>, DateTime>(
                id: 'Disconnected',
                colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                domainFn: (entry, _) => entry['date'] as DateTime,
                measureFn: (entry, _) => entry['disconnected'] as int,
                data: data,
            ),
        ];

        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text(
                    'Subscriptions Over Time',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                const SizedBox(height: 10),
                // Display the bar chart
                SizedBox(
                    height: 300, // Specify the height of the chart
                    child: charts.TimeSeriesChart(
                        series,
                        animate: true,
                        behaviors: [
                            charts.ChartTitle(
                                'Date',
                                behaviorPosition: charts.BehaviorPosition.bottom,
                                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                            ),
                            charts.ChartTitle(
                                'Subscriptions',
                                behaviorPosition: charts.BehaviorPosition.start,
                                titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                                titleStyleSpec: charts.TextStyleSpec(fontSize: 14, color: charts.Color.white),
                                titlePadding: 5,
                            ),
                        ],
                        defaultRenderer: charts.BarRendererConfig<DateTime>(),
                        domainAxis: const charts.DateTimeAxisSpec(),
                        primaryMeasureAxis: const charts.NumericAxisSpec(),
                    ),
                ),
            ],
        );
    }
}
