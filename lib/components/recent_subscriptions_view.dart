import 'package:flutter/material.dart';
import 'package:radius_db_ui/Pages/view_all_page.dart';
import 'package:radius_db_ui/classes/subscription_class.dart';
import 'subscription_details_modal.dart'; // Import the modal widget

class RecentSubscriptionsView extends StatefulWidget {
  const RecentSubscriptionsView({super.key, required this.subscriptions});

  final List<Subscription> subscriptions;

  @override
  _RecentSubscriptionsViewState createState() => _RecentSubscriptionsViewState();
}

class _RecentSubscriptionsViewState extends State<RecentSubscriptionsView> {
  List<Subscription> _recentSubscriptions = [];
  bool _isAscending = true; // Track the sorting order

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

  void _sortByName() {
    setState(() {
      _isAscending = !_isAscending;
      _recentSubscriptions.sort((a, b) {
        int result = a.name.compareTo(b.name);
        return _isAscending ? result : -result;
      });
    });
  }

  void _showSubscriptionDetails(Subscription subscription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SubscriptionDetailsModal(subscription: subscription);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth > 600 ? 13 : 10;
    final double titleFontSize = screenWidth > 600 ? 16 : 12;

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
                  fontSize: titleFontSize,
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
            columnSpacing: screenWidth * 0.075, // Adjust spacing between columns
            showCheckboxColumn: false, // Remove the checkboxes
            columns: [
              DataColumn(
                label: InkWell(
                  onTap: _sortByName,
                  child: Row(
                    children: [
                      Text('Name', style: TextStyle(fontSize: fontSize, color: Colors.grey)),
                      Icon(
                        _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                        size: fontSize,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              DataColumn(label: Text('IP', style: TextStyle(fontSize: fontSize, color: Colors.grey))),
              DataColumn(label: Text('NAS', style: TextStyle(fontSize: fontSize, color: Colors.grey))),
              DataColumn(label: Text('MAC', style: TextStyle(fontSize: fontSize, color: Colors.grey))),
              DataColumn(label: Text('Connection Date', style: TextStyle(fontSize: fontSize, color: Colors.grey))),
              DataColumn(label: Text('Status', style: TextStyle(fontSize: fontSize, color: Colors.grey))),
            ],
            rows: _recentSubscriptions.map((subscription) {
              return DataRow(
                onSelectChanged: (selected) {
                  if (selected == true) {
                    _showSubscriptionDetails(subscription);
                  }
                },
                cells: [
                  DataCell(Text(subscription.name, style: TextStyle(fontSize: fontSize))),
                  DataCell(Text(subscription.lastCon.ip, style: TextStyle(fontSize: fontSize))),
                  DataCell(Text(subscription.lastCon.nas, style: TextStyle(fontSize: fontSize))),
                  DataCell(Text(subscription.macAdd, style: TextStyle(fontSize: fontSize))),
                  DataCell(Text(subscription.createdAt.toString(), style: TextStyle(fontSize: fontSize))), // Format the DateTime to a String
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
                        fontSize: fontSize,
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
