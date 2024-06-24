// data_refresh_service.dart
import 'package:radius_db_ui/models/subscription_class.dart';
import 'package:radius_db_ui/services/api_service.dart';

Future<List<Subscription>> fetchData() async {
  // Fetch new data from your API service
  List<Subscription> subscriptions = await fetchSubscriptions();
  return subscriptions;
}
