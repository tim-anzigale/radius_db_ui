// api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/subscription_class.dart';

Future<List<Subscription>> fetchSubscriptions() async {
 // final response = await http.get(Uri.parse('https://d4a5-102-222-6-1.ngrok-free.app/api/subscriptions'));
  final response = await http.get(Uri.parse('http://localhost:5000/api/subscriptions'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Subscription.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load subscriptions');
  }
}
//final response = await http.get(Uri.parse('http://localhost:5000/api/subscriptions'));
