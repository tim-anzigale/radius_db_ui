import 'package:flutter/material.dart';
import '../data/data_service.dart';
import '../user_data.dart';
import '../components/pagination.dart';
import '../components/neumorphic.dart'; // Import the FlatNeumorphismDesign

class SubscriptionsView extends StatefulWidget {
  const SubscriptionsView({Key? key}) : super(key: key);

  @override
  _SubscriptionsViewState createState() => _SubscriptionsViewState();
}

class _SubscriptionsViewState extends State<SubscriptionsView> {
  late Future<List<UserData>> _futureUserData;
  List<UserData> _users = [];
  final int _rowsPerPage = 10;
  int _currentPage = 0;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _futureUserData = parseUserData();
  }

  @override
  Widget build(BuildContext context) {
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

          final startIndex = _currentPage * _rowsPerPage;
          final endIndex = (_currentPage + 1) * _rowsPerPage;
          final List<UserData> pageItems = _users.sublist(
            startIndex,
            endIndex > _users.length ? _users.length : endIndex,
          );                      
        

          

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'All Subscriptions',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                height: 550, // Adjusted to fit the pagination controls
                child: ListView.builder(
                  itemCount: pageItems.length,
                  itemBuilder: (context, index) {
                    final user = pageItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: FlatNeumorphismDesign(
                        child: Container(
                          height: 70, // Minimum height for each row
                          padding: const EdgeInsets.symmetric(vertical: 10), // Increased padding
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: Text(user.name, textAlign: TextAlign.center)),
                              Expanded(child: Text(user.ip, textAlign: TextAlign.center)),
                              Expanded(child: Text(user.nas, textAlign: TextAlign.center)),
                              Expanded(child: Text(user.macAdd, textAlign: TextAlign.center)),
                              Expanded(child: Text(user.planName, textAlign: TextAlign.center)),
                              Expanded(
                                child: Text(
                                  user.isDisconnected
                                      ? 'Disconnected'
                                      : user.isTerminated
                                          ? 'Terminated'
                                          : 'Connected',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: user.isDisconnected
                                        ? Colors.red
                                        : user.isTerminated
                                            ? Colors.orange
                                            : Colors.green,
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
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: FlatNeumorphismDesign(
                  child: CustomPagination(
                    totalPage: _totalPages,
                    currentPage: _currentPage,
                    onPageChange: (number) {
                      setState(() {
                        _currentPage = number;
                      });
                    },
                    show: 4,
                  ),
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
