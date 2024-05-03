// data_service.dart

import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:intl/intl.dart';
import '../user_data.dart'; // Import UserData class (update path as needed)

// Function to parse user data from JSON
Future<List<UserData>> parseUserData() async {
    try {
        // Load JSON data from assets
        final jsonString = await rootBundle.rootBundle.loadString('assets/user_data.json');
        final data = jsonDecode(jsonString) as List;

        // Parse JSON data into a list of UserData objects
        List<UserData> userDataList = data.map((json) => UserData.fromJson(json)).toList();
        
        // Debug print statements to check the parsed data
        //print('Parsed ${userDataList.length} users from JSON data.');
       // for (var user in userDataList) {
      //     print('User: ${user.name}, IP: ${user.ip}, Plan: ${user.planName}');
       // }

        return userDataList;
    } catch (e) {
        // Handle errors during JSON parsing
        print('Error parsing JSON data: $e');
        return []; // Return an empty list in case of error
    }
}
