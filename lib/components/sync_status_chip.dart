import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SyncStatusChip extends StatelessWidget {
  final DateTime? lastSyncedTime;
  final String syncStatus;

  const SyncStatusChip({
    Key? key,
    required this.lastSyncedTime,
    required this.syncStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayText;
    if (lastSyncedTime != null) {
      displayText = 'Last synced: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(lastSyncedTime!)}';
    } else {
      displayText = 'Not synced yet';
    }

    return Chip(
      label: Text(displayText),
      backgroundColor: syncStatus == "Sync successful" ? Colors.green[100] : Colors.red[100],
    );
  }
}
