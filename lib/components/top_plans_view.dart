import 'package:flutter/material.dart';
import '../user_data.dart';

class TopPlansView extends StatelessWidget {
    final List<UserData> userDataList;

    const TopPlansView({super.key, required this.userDataList});

    @override
    Widget build(BuildContext context) {
        // Calculate the frequency of each plan based on user data
        final Map<String, int> planFrequency = {};
        for (var userData in userDataList) {
            if (!planFrequency.containsKey(userData.planName)) {
                planFrequency[userData.planName] = 0;
            }
            planFrequency[userData.planName] = planFrequency[userData.planName]! + 1;
        }

        // Sort plans by frequency in descending order
        final sortedPlans = planFrequency.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text(
                    'Top Plans',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                const SizedBox(height: 10),
                // Display top plans
                sortedPlans.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sortedPlans.length,
                        itemBuilder: (context, index) {
                            final planName = sortedPlans[index].key;
                            final frequency = sortedPlans[index].value;
                            return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: ListTile(
                                    leading: Text(
                                        '#${index + 1}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                        ),
                                    ),
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
                                ),
                            );
                        },
                    )
                    : const Text('No plans found.'),
            ],
        );
    }
}
