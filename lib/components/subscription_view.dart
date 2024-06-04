import 'package:flutter/material.dart';
import 'package:radius_db_ui/components/user_data_search.dart';
import 'package:radius_db_ui/user_data.dart';
import '../services/api_service.dart'; // API service for subscriptions
import '../classes/subscription_class.dart'; // Models
import '../components/pagination.dart';
import '../components/search_bar.dart' as custom;
import 'filters.dart'; // Import the Filters class

class SubscriptionsView extends StatefulWidget {
  const SubscriptionsView({super.key, required List<Subscription> subscriptions});

  @override
  _SubscriptionsViewState createState() => _SubscriptionsViewState();
}

class _SubscriptionsViewState extends State<SubscriptionsView> {
  late Future<List<Subscription>> _futureSubscriptions;
  List<Subscription> _subscriptions = [];
  List<Subscription> _filteredSubscriptions = [];
  final int _rowsPerPage = 10;
  int _currentPage = 0;
  int _totalPages = 0;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter;

  @override
  void initState() {
    super.initState();
    _futureSubscriptions = fetchSubscriptions();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    List<Subscription> filteredList = searchSubscriptions(_subscriptions, _searchController.text);

    if (_selectedFilter == 'Terminated') {
      filteredList = filteredList.where((subscription) => subscription.isTerminated && !subscription.isDisconnected).toList();
    } else if (_selectedFilter == 'Disconnected') {
      filteredList = filteredList.where((subscription) => !subscription.isTerminated && subscription.isDisconnected).toList();
    } else if (_selectedFilter == 'Newest') {
      filteredList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_selectedFilter == 'Connected') {
      filteredList = filteredList.where((subscription) => !subscription.isTerminated && !subscription.isDisconnected).toList();
    }

    setState(() {
      _filteredSubscriptions = filteredList;
      _totalPages = (_filteredSubscriptions.length / _rowsPerPage).ceil();
      _currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth > 600 ? 13 : 10;
    final double titleFontSize = screenWidth > 600 ? 16 : 12;
    final double filterWidth = screenWidth > 600 ? 150 : 100;

    return FutureBuilder<List<Subscription>>(
      future: _futureSubscriptions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          _subscriptions = snapshot.data ?? [];
          print(_subscriptions);
          if (_searchController.text.isEmpty && _selectedFilter == null) {
            _filteredSubscriptions = _subscriptions;
          }
          _totalPages = (_filteredSubscriptions.isEmpty ? 1 : (_filteredSubscriptions.length / _rowsPerPage).ceil());

          // Ensure current page is within valid range
          if (_currentPage >= _totalPages) {
            _currentPage = _totalPages - 1;
          }
          if (_currentPage < 0) {
            _currentPage = 0;
          }

          final startIndex = _currentPage * _rowsPerPage;
          final endIndex = (_currentPage + 1) * _rowsPerPage;
          final List<Subscription> pageItems = _filteredSubscriptions.sublist(
            startIndex,
            endIndex > _filteredSubscriptions.length ? _filteredSubscriptions.length : endIndex,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'All Subscriptions',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double availableWidth = constraints.maxWidth;
                        double adjustedFilterWidth = availableWidth > 600 ? filterWidth : availableWidth - 40;

                        return custom.SearchBar(
                          searchController: _searchController,
                          selectedFilter: _selectedFilter,
                          onFilterChanged: (String? newValue) {
                            setState(() {
                              _selectedFilter = newValue;
                              _onSearchChanged();
                            });
                          },
                          filterWidth: adjustedFilterWidth,
                          fontSize: fontSize,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: screenWidth * 0.07, // Adjust spacing between columns
                    columns: [
                      DataColumn(label: Text('Name', style: TextStyle(fontSize: fontSize))),
                      DataColumn(label: Text('IP', style: TextStyle(fontSize: fontSize))),
                      DataColumn(label: Text('NAS', style: TextStyle(fontSize: fontSize))),
                      DataColumn(label: Text('MAC', style: TextStyle(fontSize: fontSize))),
                      DataColumn(label: Text('Plan', style: TextStyle(fontSize: fontSize))),
                      DataColumn(label: Text('Status', style: TextStyle(fontSize: fontSize))),
                    ],
                    rows: pageItems.map((subscription) {
                      return DataRow(
                        cells: [
                          DataCell(Text(subscription.name, style: TextStyle(fontSize: fontSize))),
                          DataCell(Text(subscription.lastCon.ip, style: TextStyle(fontSize: fontSize))),
                          DataCell(Text(subscription.lastCon.nas, style: TextStyle(fontSize: fontSize))),
                          DataCell(Text(subscription.macAdd, style: TextStyle(fontSize: fontSize))),
                          DataCell(Text(subscription.plan.name, style: TextStyle(fontSize: fontSize))),
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
              ),
              if (_filteredSubscriptions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Showing data ${startIndex + 1} to ${endIndex > _filteredSubscriptions.length ? _filteredSubscriptions.length : endIndex} of ${_filteredSubscriptions.length} entries',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (_totalPages > 1)
                        CustomPagination(
                          totalPage: _totalPages,
                          currentPage: _currentPage,
                          onPageChange: (number) {
                            setState(() {
                              _currentPage = number;
                            });
                          },
                          show: 4,
                          fontSize: fontSize,
                        ),
                    ],
                  ),
                ),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}


