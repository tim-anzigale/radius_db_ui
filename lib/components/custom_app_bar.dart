import 'package:flutter/material.dart';
import 'sync_status_chip.dart'; // Import the SyncStatusChip

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final DateTime? lastSyncedTime;
  final String syncStatus;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.lastSyncedTime,
    this.syncStatus = "Not synced yet",
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      surfaceTintColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SyncStatusChip(
            lastSyncedTime: lastSyncedTime,
            syncStatus: syncStatus,
          ),
        ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
