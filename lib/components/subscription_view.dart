import 'package:flutter/material.dart';
import '../data/data_service.dart';
import '../user_data.dart';
import '../components/pagination.dart';
import '../components/neumorphic.dart';
import '../components/search_bar.dart' as custom; // Import the new SearchBar file with an alias
import 'filters.dart'; // Import the Filters class

class SubscriptionsView extends StatefulWidget {
  const SubscriptionsView({super.key});

  @override
  _SubscriptionsViewState createState() => _SubscriptionsViewState();
}

class _SubscriptionsViewState extends State<SubscriptionsView> {
  late Future<List<UserData>> _futureUserData;
  List<UserData> _users = [];
  List<UserData> _filteredUsers = [];
  final int _rowsPerPage = 10;
  int _currentPage = 0;
  int _totalPages = 0;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter; // Selected filter option

  @override
  void initState() {
    super.initState();
    _futureUserData = parseUserData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth > 600 ? 12 : 10;
    final double titleFontSize = screenWidth > 600 ? 16 : 12;
    final double filterWidth = screenWidth > 600 ? 150 : 100; // Adjust width based on screen size

    return FutureBuilder<List<UserData>>(
      future: _futureUserData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          _users = snapshot.data!;
          _totalPages = (_users.length / _rowsPerPage).ceil();

          _filteredUsers = _searchController.text.isEmpty
              ? _users
              : _users.where((user) {
                  return user.name.toLowerCase().contains(_searchController.text.toLowerCase());
                }).toList();

          final startIndex = _currentPage * _rowsPerPage;
          final endIndex = (_currentPage + 1) * _rowsPerPage;
          final List<UserData> pageItems = _filteredUsers.sublist(
            startIndex,
            endIndex > _filteredUsers.length ? _filteredUsers.length : endIndex,
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
                    child: custom.SearchBar(
                      searchController: _searchController,
                      selectedFilter: _selectedFilter,
                      onFilterChanged: (String? newValue) {
                        setState(() {
                          _selectedFilter = newValue;
                        });
                      },
                      filterWidth: filterWidth, // Pass adjusted width
                      fontSize: fontSize, // Pass adjusted font size
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Text('Name', textAlign: TextAlign.center)),
                    Expanded(child: Text('IP', textAlign: TextAlign.center)),
                    Expanded(child: Text('NAS', textAlign: TextAlign.center)),
                    Expanded(child: Text('MAC', textAlign: TextAlign.center)),
                    Expanded(child: Text('Plan', textAlign: TextAlign.center)),
                    Expanded(child: Text('Status', textAlign: TextAlign.center)),
                  ],
                ),
              ),
 SizedBox(
  height: 550,
  child: ListView.builder(
    itemCount: pageItems.length,
    itemBuilder: (context, index) {
      final user = pageItems[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: FlatNeumorphismDesign(
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjusted alignment
              children: [
                Expanded(child: Text(user.name, textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))),
                Expanded(child: Text(user.ip, textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))),
                Expanded(child: Text(user.nas, textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))),
                Expanded(child: Text(user.macAdd, textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))),
                Expanded(child: Text(user.planName, textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))),
                Expanded(
                  child: Container(
                    width: 100, // Adjust the width to your preference
                    margin: const EdgeInsets.only(right: 10), // Adding right margin
                    decoration: BoxDecoration(
                      color: user.isDisconnected
                          ? Colors.red.withOpacity(0.1)
                          : user.isTerminated
                              ? Colors.orange.withOpacity(0.1)
                              : Colors.green.withOpacity(0.1),
                      border: Border.all(
                        color: user.isDisconnected
                            ? Colors.red
                            : user.isTerminated
                                ? Colors.orange
                                : Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      user.isDisconnected
                          ? 'Disconnected'
                          : user.isTerminated
                              ? 'Terminated'
                              : 'Connected',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: user.isDisconnected
                            ? Colors.red
                            : user.isTerminated
                                ? Colors.orange
                                : Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Showing data ${startIndex + 1} to $endIndex of ${_filteredUsers.length} entries',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis, // Add this to handle overflow
                      ),
                    ),
                    CustomPagination(
                      totalPage: _totalPages,
                      currentPage: _currentPage,
                      onPageChange: (number) {
                        setState(() {
                          _currentPage = number;
                        });
                      },
                      show: 4,
                      fontSize: fontSize, // Pass adjusted font size to CustomPagination
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
