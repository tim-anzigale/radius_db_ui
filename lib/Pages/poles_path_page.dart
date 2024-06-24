import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/poles_path_class.dart';
import '../components/neumorphic.dart';
import '../components/poles_path_view.dart';
import '../services/api_service.dart'; // Import your API service

class PolesPathPage extends StatefulWidget {
  const PolesPathPage({Key? key}) : super(key: key);

  @override
  _PolesPathPageState createState() => _PolesPathPageState();
}

class _PolesPathPageState extends State<PolesPathPage> {
  late Future<List<PolePath>> _futurePolePaths;

  @override
  void initState() {
    super.initState();
    _futurePolePaths = fetchPolesPath();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pole Paths'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder<List<PolePath>>(
          future: _futurePolePaths,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error fetching pole paths: ${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final polePaths = snapshot.data!;

              return Center(
                child: isDarkMode
                    ? DarkFlatNeumorphismDesign(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: PolesPathView(polePaths: polePaths),
                        ),
                      )
                    : FlatNeumorphismDesign(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: PolesPathView(polePaths: polePaths),
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
