import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radius_db_ui/components/view_all.dart';
import 'package:radius_db_ui/user_data.dart';
import '../services/api_service.dart'; // Import api_service.dart
import '../classes/subscription_class.dart';
import '../Pages/view_all_page.dart';

class RecentSubscriptionsView extends StatefulWidget {
  const RecentSubscriptionsView({super.key, required List<UserData> userDataList});

  @override
  _RecentSubscriptionsViewState createState() => _RecentSubscriptionsViewState();
}

class _RecentSubscriptionsViewState extends State<RecentSubscriptionsView> {
  late Future<List<Subscription>> _futureSubscriptions;
  List<Subscription> _subscriptions = [];
  List<Subscription> _recentSubscriptions = []; // Filtered list based on date
  double _fontSize = 16; // Initial font size

  @override
  void initState() {
    super.initState();
    _futureSubscriptions = fetchSubscriptions(); // Fetch subscriptions from API
  }

  void _filterRecentSubscriptions() {
    final DateTime now = DateTime.now();
    final DateTime cutoffDate = now.subtract(const Duration(days: 30));

    _recentSubscriptions = _subscriptions.where((subscriptions) => subscriptions.createdAt.isAfter(cutoffDate)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subscription>>(
      future: _futureSubscriptions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          _subscriptions = snapshot.data!;
          _filterRecentSubscriptions();
          if (kDebugMode) {
            print(_recentSubscriptions);
          } 

          return LayoutBuilder(
            builder: (context, constraints) {
              // Recalculate font size based on screen width
              _fontSize = constraints.maxWidth > 600 ? 13 : 10;
              return _buildRecentSubscriptions(context);
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildRecentSubscriptions(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Recent Subscriptions',
                style: TextStyle(
                  fontSize: _fontSize + 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ViewAllText(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ViewAllSubscriptionsPage(userDataList: []),
                ));
              },
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columnSpacing: screenWidth * 0.07, // Adjust spacing between columns
              columns: [
                DataColumn(label: Text('Name', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('IP', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('NAS', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('MAC', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('Connection Date', style: TextStyle(fontSize: _fontSize))),
                DataColumn(label: Text('Status', style: TextStyle(fontSize: _fontSize))),
              ],
              rows: _recentSubscriptions.take(10).map((subscription) {
                return DataRow(
                  cells: [
                    DataCell(Text(subscription.name, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Text(subscription.lastCon.ip, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Text(subscription.lastCon.nas, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Text(subscription.macAdd, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Text(subscription.createdAt as String, style: TextStyle(fontSize: _fontSize))),
                    DataCell(Container(
                      width: 110,
                      decoration: BoxDecoration(
                        color: subscription.isDisconnected
                            ? Colors.red.withOpacity(0.1)
                            : subscription.isTerminated
                                ? Colors.orange.withOpacity(0.1)
                                : Colors.green.withOpacity(0.1),
                        border: Border.all(
                          color: subscription.isDisconnected
                              ? Colors.red
                              : subscription.isTerminated
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        subscription.isDisconnected
                            ? 'Disconnected'
                            : subscription.isTerminated
                                ? 'Terminated'
                                : 'Connected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _fontSize,
                          color: subscription.isDisconnected
                              ? Colors.red
                              : subscription.isTerminated
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                      ),
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
