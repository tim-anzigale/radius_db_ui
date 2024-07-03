import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/pole_class.dart';
import '../components/neumorphic.dart';
import '../components/poles_view.dart';
import '../services/api_service.dart'; // Import your API service

class PolesPage extends StatefulWidget {
  const PolesPage({Key? key}) : super(key: key);

  @override
  _PolesPageState createState() => _PolesPageState();
}

class _PolesPageState extends State<PolesPage> {
  late Future<List<Pole>> _futurePoles;

  @override
  void initState() {
    super.initState();
    _futurePoles = fetchPolesList();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poles'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Pole>>(
          future: _futurePoles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error fetching poles: ${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final poles = snapshot.data!;

              return SingleChildScrollView(
                child: Center(
                  child: isDarkMode
                      ? DarkFlatNeumorphismDesign(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PolesView(poles: poles),
                          ),
                        )
                      : FlatNeumorphismDesign(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PolesView(poles: poles),
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
