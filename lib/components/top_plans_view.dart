import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/models/subscription_class.dart';
import '../services/api_service.dart'; // Import your API service
import '../components/neumorphic.dart';
import '../theme_provider.dart'; // Import the theme provider

class TopPlansView extends StatefulWidget {
  final VoidCallback onViewMorePressed;

  const TopPlansView({Key? key, required this.onViewMorePressed}) : super(key: key);

  @override
  _TopPlansViewState createState() => _TopPlansViewState();
}

class _TopPlansViewState extends State<TopPlansView> {
  double _fontSize = 13;
  List<Subscription> _subscriptions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      Map<String, dynamic> result = await fetchSubscriptions(1, 100); // Fetch a larger number of subscriptions
      List<Subscription> newData = result['subscriptions'];
      setState(() {
        _subscriptions = newData;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final sortedPlans = _getSortedPlans(_subscriptions);
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildTopPlansSection(context, sortedPlans);
      },
    );
  }

  List<MapEntry<String, int>> _getSortedPlans(List<Subscription> subscriptions) {
    final Map<String, int> planFrequency = {};
    for (var subscription in subscriptions) {
      planFrequency[subscription.plan.name] = (planFrequency[subscription.plan.name] ?? 0) + 1;
    }
    final sortedPlans = planFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedPlans;
  }

  Widget _buildTopPlansSection(BuildContext context, List<MapEntry<String, int>> sortedPlans) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleSection(context),
        const SizedBox(height: 10),
        Expanded(
          child: _buildTopPlansList(context, sortedPlans),
        ),
      ],
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Top Plans',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _refreshData,
                tooltip: 'Refresh',
              ),
              TextButton(
                onPressed: widget.onViewMorePressed,
                child: const Text('View More'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopPlansList(BuildContext context, List<MapEntry<String, int>> sortedPlans) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return ListView.builder(
      itemCount: sortedPlans.length,
      itemBuilder: (context, index) {
        final planName = sortedPlans[index].key;
        final frequency = sortedPlans[index].value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
          child: ListTile(
            title: Text(
              planName,
              style: TextStyle(
                fontSize: _fontSize,
                color: isDarkMode ? Colors.grey[200] : Colors.black,
              ),
            ),
            trailing: Text(
              '$frequency',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey[200] : Colors.black,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
          ),
        );
      },
    );
  }
}
