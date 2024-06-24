import 'package:flutter/material.dart';
import 'package:radius_db_ui/models/subscription_class.dart';
import '../components/neumorphic.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class SubscriptionDetailsPage extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionDetailsPage({Key? key, required this.subscription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Subscription Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        titleTextStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isDarkMode
              ? DarkFlatNeumorphismDesign(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildSubscriptionDetails(isDarkMode),
                  ),
                )
              : FlatNeumorphismDesign(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildSubscriptionDetails(isDarkMode),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionDetails(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailsTable(isDarkMode),
        const SizedBox(height: 16),
        _buildStatusChip(),
      ],
    );
  }

  Widget _buildDetailsTable(bool isDarkMode) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      border: TableBorder(
        horizontalInside: BorderSide(
          color: isDarkMode ? Colors.white30 : Colors.black26,
          width: 0.5,
        ),
      ),
      children: [
        _buildTableRow('Name:', subscription.name, isDarkMode),
        _buildTableRow('IP:', subscription.lastCon.ip, isDarkMode),
        _buildTableRow('NAS:', subscription.lastCon.nas, isDarkMode),
        _buildTableRow('MAC:', subscription.macAdd, isDarkMode),
        _buildTableRow('Plan:', subscription.plan.name, isDarkMode),
        _buildTableRow('Connection Date:', subscription.createdAt.toString(), isDarkMode),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value, bool isDarkMode) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip() {
    Color backgroundColor;
    Color textColor;
    String statusText;

    if (subscription.isDisconnected) {
      backgroundColor = Colors.red.withOpacity(0.1);
      textColor = Colors.red;
      statusText = 'Disconnected';
    } else if (subscription.isTerminated) {
      backgroundColor = Colors.orange.withOpacity(0.1);
      textColor = Colors.orange;
      statusText = 'Terminated';
    } else {
      backgroundColor = Colors.green.withOpacity(0.1);
      textColor = Colors.green;
      statusText = 'Connected';
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: textColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        statusText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
