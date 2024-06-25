import '../models/subscription_class.dart';

List<Subscription> searchSubscriptions(List<Subscription> subscriptions, String query) {
  if (query.isEmpty) {
    return subscriptions;
  } else {
    final results = subscriptions.where((subscription) {
      return subscription.name.toLowerCase().contains(query.toLowerCase()) ||
          subscription.lastCon.ip.toLowerCase().contains(query.toLowerCase()) ||
          subscription.lastCon.nas.toLowerCase().contains(query.toLowerCase()) ||
          subscription.macAdd.toLowerCase().contains(query.toLowerCase()) ||
          subscription.plan.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return results.isNotEmpty ? results : [];
  }
}
