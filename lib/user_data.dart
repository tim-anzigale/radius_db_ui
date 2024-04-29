import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:intl/intl.dart';

class UserData {
    final String id;
    final String name;
    final String ip;
    final String macAdd;
    final String planName;
    final String subnetMask;
    final String nas;
    final DateTime lastConnectionTime;
    final bool isDisconnected;
    final bool isTerminated;
    final DateTime createdAt;
    final String createdAtString;
    final String lastConnectionTimeString;

    UserData({
        required this.id,
        required this.name,
        required this.ip,
        required this.macAdd,
        required this.planName,
        required this.subnetMask,
        required this.nas,
        required this.lastConnectionTime,
        required this.isDisconnected,
        required this.isTerminated,
        required this.createdAt,
        required this.createdAtString,
        required this.lastConnectionTimeString,
    });

    // Factory constructor to create UserData from JSON
    factory UserData.fromJson(Map<String, dynamic> json) {
        // Date format for parsing the dates
        final dateFormat = DateFormat("M/d/yyyy HH:mm:ss.SSS'Z'");

        // Parse the JSON data
        DateTime parsedLastConnectionTime = dateFormat.parse(json['last_con']['time']);
        DateTime parsedCreatedAt = dateFormat.parse(json['created_at']);

        return UserData(
            id: json['_id'] as String,
            name: json['name'] as String,
            ip: json['ips']['ip'] as String,
            macAdd: json['mac_add'] as String,
            planName: json['plan']['name'] as String,
            subnetMask: json['ips']['subnetMask'] as String,
            nas: json['last_con']['NAS'] as String,
            lastConnectionTime: parsedLastConnectionTime,
            lastConnectionTimeString: dateFormat.format(parsedLastConnectionTime),
            isDisconnected: json['isDisconnected'] == true || json['isDisconnected'] == 'true',
            isTerminated: json['isTerminated'] == true || json['isTerminated'] == 'true',
            createdAt: parsedCreatedAt,
            createdAtString: dateFormat.format(parsedCreatedAt),
        );
    }
}

// Function to parse user data from JSON
Future<List<UserData>> parseUserData() async {
    // Load JSON data from assets
    final jsonString = await rootBundle.rootBundle.loadString('assets/user_data.json');
    final data = jsonDecode(jsonString) as List;

    // Parse JSON data into a list of UserData objects
    return data.map((json) => UserData.fromJson(json)).toList();
}
