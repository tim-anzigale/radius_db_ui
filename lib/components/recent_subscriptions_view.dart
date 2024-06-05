import 'package:flutter/material.dart';
import 'package:radius_db_ui/Pages/view_all_page.dart';
import 'package:radius_db_ui/classes/subscription_class.dart';



class RecentSubscriptionsView extends StatefulWidget {
  const RecentSubscriptionsView({super.key, required this.subscriptions});

  final List<Subscription> subscriptions;

  @override
  _RecentSubscriptionsViewState createState() => _RecentSubscriptionsViewState();
}

class _RecentSubscriptionsViewState extends State<RecentSubscriptionsView> {
  List<Subscription> _recentSubscriptions = [];

  @override
  void initState() {
    super.initState();
    _filterRecentSubscriptions();
  }

  void _filterRecentSubscriptions() {
    final DateTime now = DateTime.now();
    final DateTime cutoffDate = now.subtract(const Duration(days: 30));
    _recentSubscriptions = widget.subscriptions.where((subscription) => subscription.createdAt.isAfter(cutoffDate)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildRecentSubscriptions(context, constraints.maxWidth);
      },
    );
  }

  Widget _buildRecentSubscriptions(BuildContext context, double screenWidth) {
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewAllSubscriptionsPage(subscriptions: widget.subscriptions),
                  ),
                );
              },
              child: const Text('View All'),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: screenWidth * 0.07, // Adjust spacing between columns
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('IP')),
              DataColumn(label: Text('NAS')),
              DataColumn(label: Text('MAC')),
              DataColumn(label: Text('Connection Date')),
              DataColumn(label: Text('Status')),
            ],
            rows: _recentSubscriptions.map((subscription) {
              return DataRow(
                cells: [
                  DataCell(Text(subscription.name)),
                  DataCell(Text(subscription.lastCon.ip)),
                  DataCell(Text(subscription.lastCon.nas)),
                  DataCell(Text(subscription.macAdd)),
                  DataCell(Text(subscription.createdAt.toString())), // Format the DateTime to a String
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
      ],
    );
  }
}
