import 'package:flutter/material.dart';
import 'package:radius_db_ui/components/user_data_search.dart';
import 'package:radius_db_ui/user_data.dart';
import '../services/api_service.dart'; // API service for subscriptions
import '../models/subscription_class.dart'; // Models
import '../components/pagination.dart';
import '../components/search_bar.dart' as custom;
import 'filters.dart'; // Import the Filters class
import 'subscription_details_modal.dart'; // Import the modal widget
import '../services/export_service.dart'; // Import the export service

class SubscriptionsView extends StatefulWidget {
  const SubscriptionsView({Key? key, required this.onSubscriptionSelected}) : super(key: key);

  final void Function(Subscription) onSubscriptionSelected;

  @override
  _SubscriptionsViewState createState() => _SubscriptionsViewState();
}

class _SubscriptionsViewState extends State<SubscriptionsView> {
  List<Subscription> _subscriptions = [];
  List<Subscription> _filteredSubscriptions = [];
  int _rowsPerPage = 10;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalSubscriptions = 0;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _loadPage(_currentPage);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPage(int page) async {
    try {
      final result = await fetchSubscriptions(page + 1, 100); // Fetch minimum of 100 subscriptions
      setState(() {
        if (page == 0) {
          _subscriptions = result['subscriptions'];
          _totalSubscriptions = result['totalSubscriptions'];
        } else {
          _subscriptions.addAll(result['subscriptions']);
        }
        _filteredSubscriptions = _subscriptions;
        _totalPages = (_totalSubscriptions / _rowsPerPage).ceil();
        _currentPage = page;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: $error')),
      );
    }
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

  void _sortByName() {
    setState(() {
      _isAscending = !_isAscending;
      _filteredSubscriptions.sort((a, b) {
        int result = a.name.compareTo(b.name);
        return _isAscending ? result : -result;
      });
    });
  }

  void _showSubscriptionDetails(Subscription subscription) {
    widget.onSubscriptionSelected(subscription);
  }

  void _export(String format) async {
    switch (format) {
      case 'CSV':
        await ExportService.exportToCSV(_filteredSubscriptions, 'subscriptions');
        break;
      case 'Excel':
        await ExportService.exportToExcel(_filteredSubscriptions, 'subscriptions');
        break;
      case 'PDF':
        await ExportService.exportToPDF(_filteredSubscriptions, 'subscriptions');
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$format Exported')),
    );
  }

  void _onItemsPerPageChanged(int newValue) {
    setState(() {
      _rowsPerPage = newValue;
      _totalPages = (_totalSubscriptions / _rowsPerPage).ceil();
      _currentPage = 0;
      _loadPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth > 600 ? 13 : 10;
    final double titleFontSize = screenWidth > 600 ? 16 : 12;
    final double filterWidth = screenWidth > 600 ? 150 : 100;

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
              child: Row(
                children: [
                  LayoutBuilder(
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
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: () {
                      final RenderBox button = context.findRenderObject() as RenderBox;
                      final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                      final RelativeRect position = RelativeRect.fromRect(
                        Rect.fromPoints(
                          button.localToGlobal(Offset.zero, ancestor: overlay),
                          button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                        ),
                        Offset.zero & overlay.size,
                      );

                      showMenu(
                        context: context,
                        position: position.shift(const Offset(10, 0)),
                        items: [
                          const PopupMenuItem(
                            value: 'CSV',
                            child: Text('Export as CSV'),
                          ),
                          const PopupMenuItem(
                            value: 'Excel',
                            child: Text('Export as Excel'),
                          ),
                          const PopupMenuItem(
                            value: 'PDF',
                            child: Text('Export as PDF'),
                          ),
                        ],
                      ).then((value) {
                        if (value != null) {
                          _export(value);
                        }
                      });
                    },
                    tooltip: 'Export',
                  ),
                ],
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columnSpacing: screenWidth * 0.065,
              showCheckboxColumn: false,
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
                DataColumn(label: Text('Plan', style: TextStyle(fontSize: fontSize, color: Colors.grey))),
                DataColumn(label: Text('Status', style: TextStyle(fontSize: fontSize, color: Colors.grey))),
              ],
              rows: _filteredSubscriptions
                  .skip(_currentPage * _rowsPerPage)
                  .take(_rowsPerPage)
                  .map((subscription) {
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
        if (_filteredSubscriptions.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                'No matching results found.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  _filteredSubscriptions.isEmpty
                      ? 'No entries'
                      : 'Showing data ${_currentPage * _rowsPerPage + 1} to ${(_currentPage + 1) * _rowsPerPage > _filteredSubscriptions.length ? _filteredSubscriptions.length : (_currentPage + 1) * _rowsPerPage} of $_totalSubscriptions entries',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomPagination(
                totalItems: _totalSubscriptions,
                currentPage: _currentPage,
                onPageChange: (number) {
                  _loadPage(number); // Load the new page
                },
                onItemsPerPageChange: _onItemsPerPageChanged,
                show: _rowsPerPage,
                fontSize: fontSize,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
