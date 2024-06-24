import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/plan_class.dart';
import '../components/neumorphic.dart';
import '../components/plans_view.dart';
import '../services/api_service.dart'; // Import your API service

class PlansPage extends StatefulWidget {
  final void Function(Plan) onPlanSelected;

  const PlansPage({super.key, required this.onPlanSelected});

  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  late Future<List<Plan>> _futurePlans;

  @override
  void initState() {
    super.initState();
    _futurePlans = fetchPlans();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plans'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder<List<Plan>>(
          future: _futurePlans,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final plans = snapshot.data!;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0), // Add padding to ensure it does not touch the screen edges
                child: Center(
                  child: isDarkMode
                      ? DarkFlatNeumorphismDesign(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PlansView(plans: plans, onPlanSelected: widget.onPlanSelected),
                          ),
                        )
                      : FlatNeumorphismDesign(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PlansView(plans: plans, onPlanSelected: widget.onPlanSelected),
                          ),
                        ),
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
