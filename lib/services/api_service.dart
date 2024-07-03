import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/poles_path_class.dart';
import '../models/subscription_class.dart';
import '../models/plan_class.dart';
import '../models/pole_class.dart'; // Import the Pole model
import '../models/users_class.dart'; 

Future<Map<String, dynamic>> fetchSubscriptions(int page, int pageSize) async {
  final response = await http.get(Uri.parse('https://localhost:5000/api/subscriptions?page=$page&pageSize=$pageSize'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> subscriptionsJson = jsonResponse['subscriptions'];
    List<Subscription> subscriptions = subscriptionsJson.map((data) => Subscription.fromJson(data)).toList();
    int totalSubscriptions = jsonResponse['totalSubscriptions'];
    return {
      'subscriptions': subscriptions,
      'totalSubscriptions': totalSubscriptions,
    };
  } else {
    throw Exception('Failed to load subscriptions');
  }
}

Future<List<Plan>> fetchPlans() async {
  final response = await http.get(Uri.parse('https://dev.api.inet.africa:5000/api/plans'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Plan.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load plans');
  }
}

Future<List<Pole>> fetchPolesList() async {
  final response = await http.get(Uri.parse('http://ops.inet.africa:8080/api/pole/list?api_key=fv%267pc<{obF1H05s618I8FLz2[I1fWG&'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List polesJson = jsonResponse['poles'];
    return polesJson.map((data) => Pole.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load poles list');
  }
}

Future<List<PolePath>> fetchPolesPath() async {
  final response = await http.get(Uri.parse('http://ops.inet.africa:8080/api/pole/path?api_key=fv%267pc<{obF1H05s618I8FLz2[I1fWG&'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List pathsJson = jsonResponse['paths'];
    return pathsJson.map((data) => PolePath.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load poles path');
  }
}

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://ops.inet.africa:8080/api/user/list?api_key=fv%267pc<{obF1H05s618I8FLz2[I1fWG&'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> usersJson = jsonResponse['users']; // Adjust the key based on the actual structure
    return usersJson.map((data) => User.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
