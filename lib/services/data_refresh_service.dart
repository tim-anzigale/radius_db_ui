// data_refresh_service.dart
import 'package:radius_db_ui/models/subscription_class.dart';
import 'package:radius_db_ui/services/api_service.dart';

// Function to fetch subscriptions with pagination
Future<List<Subscription>> fetchData({int page = 1, int pageSize = 10}) async {
  try {
    // Fetch new data from your API service with pagination
    List<Subscription> subscriptions = await fetchSubscriptions(page, pageSize);
    return subscriptions;
  } catch (error) {
    print('Error fetching data: $error');
    throw Exception('Failed to fetch data');
  }
}
