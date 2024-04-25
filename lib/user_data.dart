import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

// lib/user_data.dart

class UserData {
  final String id;
  final String name;
  final String ip;
  final String macAdd;
  final String planName;
  final String subnetMask;
  final String nas;
  final String lastConnectionTime;
  final bool isDisconnected;
  final bool isTerminated;

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
  });

  // A factory constructor to create UserData from JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] as String,
      name: json['name'] as String,
      ip: json['ips']['ip'] as String,
      macAdd: json['mac_add'] as String,
      planName: json['plan']['name'] as String,
      subnetMask: json['ips']['subnetMask'] as String,
      nas: json['last_con']['NAS'] as String, // Extract NAS information,
      lastConnectionTime: json['last_con']['time'] as String,
      isDisconnected: json['isDisconnected'] as bool,
      isTerminated: json['isTerminated'] == 'true',
    );
  }
}

Future<List<UserData>> parseUserData() async {
  // Load JSON data from the assets folder
  final jsonString = await rootBundle.rootBundle.loadString('assets/user_data.json');
  final data = jsonDecode(jsonString) as List;

  // Parse JSON data into a list of UserData objects
  return data.map((json) => UserData.fromJson(json)).toList();
}
