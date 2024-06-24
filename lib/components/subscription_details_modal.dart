import 'package:flutter/material.dart';
import '../models/subscription_class.dart'; // Update the path if necessary

class SubscriptionDetailsModal extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionDetailsModal({Key? key, required this.subscription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Subscription Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${subscription.name}'),
            Text('IP: ${subscription.lastCon.ip}'),
            Text('NAS: ${subscription.lastCon.nas}'),
            Text('MAC: ${subscription.macAdd}'),
            Text('Plan: ${subscription.plan.name}'),
            Text('Status: ${subscription.isDisconnected ? 'Disconnected' : subscription.isTerminated ? 'Terminated' : 'Connected'}'),
            Text('Created At: ${subscription.createdAt}'),
            Text('Updated At: ${subscription.updatedAt}'),
            // Add more fields as necessary
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
