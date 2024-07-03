import 'dart:async';
import 'dart:ui';
import 'package:mutex/mutex.dart';
import 'package:intl/intl.dart';
import '../models/subscription_class.dart';
import 'api_service.dart'; // Ensure you import your api_service.dart

class DataSyncScheduler {
  final Duration interval;
  final Mutex _mutex = Mutex();
  Timer? _timer;
  DateTime? lastSyncedTime;
  String syncStatus = "Not synced yet";
  final List<VoidCallback> _listeners = [];

  DataSyncScheduler({required this.interval});

  void start() {
    _timer = Timer.periodic(interval, (timer) async {
      await _syncData();
    });
  }

  void stop() {
    _timer?.cancel();
  }

  Future<void> _syncData() async {
    if (_mutex.isLocked) {
      print("Sync already in progress. Skipping this interval.");
      return;
    }

    await _mutex.acquire();
    try {
      Map<String, dynamic> result = await fetchSubscriptions(1, 100);
      List<Subscription> subscriptions = result['subscriptions'];
      // TODO: Update your data structure with the new data
      syncStatus = "Sync successful";
      print("Data synced successfully at ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}");
    } catch (e) {
      syncStatus = "Sync failed: $e";
      print("Error occurred during sync: $e");
    } finally {
      lastSyncedTime = DateTime.now();
      _mutex.release();
      _notifyListeners();
      _notifyAdmin();
    }
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void _notifyAdmin() {
    // TODO: Implement notification logic (e.g., sending an email, updating UI, etc.)
    print("Last sync status: $syncStatus at ${DateFormat('yyyy-MM-dd HH:mm:ss').format(lastSyncedTime!)}");
  }
}
