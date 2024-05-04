import 'package:flutter/material.dart';
import '../data/data_service.dart'; // Import parseUserData from data_service.dart
import '../user_data.dart'; // Import the UserData class

class TopPlansView extends StatefulWidget {
    const TopPlansView({super.key, required List<UserData> userDataList});

    @override
    _TopPlansViewState createState() => _TopPlansViewState();
}

class _TopPlansViewState extends State<TopPlansView> {
    late Future<List<UserData>> _futureUserData;

    @override
    void initState() {
        super.initState();
        // Load and parse user data
        _futureUserData = parseUserData();
    }

    @override
    Widget build(BuildContext context) {
        return FutureBuilder<List<UserData>>(
            future: _futureUserData,
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display loading indicator while waiting for data
                    return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                    // Display error message if an error occurs
                    return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                    // Data is loaded successfully
                    final users = snapshot.data!;

                    // Calculate the frequency of each plan based on user data
                    final Map<String, int> planFrequency = {};
                    for (var user in users) {
                        planFrequency[user.planName] = (planFrequency[user.planName] ?? 0) + 1;
                    }

                    // Convert the map entries to a list and sort by frequency
                    final sortedPlans = planFrequency.entries.toList()
                        ..sort((a, b) => b.value.compareTo(a.value));

                    // Display the title and the list of plans with their frequency
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // Add the title "Top Plans"
                            const Text(
                                'Top Plans',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            const SizedBox(height: 10),
                            // Display the list of plans and their frequency
                            Expanded(
                                child: ListView.builder(
                                    itemCount: sortedPlans.length,
                                    itemBuilder: (context, index) {
                                        final planName = sortedPlans[index].key;
                                        final frequency = sortedPlans[index].value;
                                        return ListTile(
                                            title: Text(planName),
                                            trailing: Text(
                                                '$frequency users',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                            ),
                                            tileColor: Colors.grey[100], // Light grey background for each item
                                        );
                                    },
                                ),
                            ),
                        ],
                    );
                }
            },
        );
    }
}
