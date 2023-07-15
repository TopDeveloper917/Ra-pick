import 'package:flutter/material.dart';

class GenericSettingsScreen extends StatefulWidget {
  @override
  _GenericSettingsScreenState createState() => _GenericSettingsScreenState();
}

class _GenericSettingsScreenState extends State<GenericSettingsScreen> {
  bool isPaymentMethodEnabled = true;
  bool isDocumentAccessEnabled = true;
  bool isEarningsSummaryEnabled = true;
  bool isPromotionsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generic Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Payment Methods'),
            value: isPaymentMethodEnabled,
            onChanged: (value) {
              setState(() {
                isPaymentMethodEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Document Access'),
            value: isDocumentAccessEnabled,
            onChanged: (value) {
              setState(() {
                isDocumentAccessEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Earnings Summary'),
            value: isEarningsSummaryEnabled,
            onChanged: (value) {
              setState(() {
                isEarningsSummaryEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Promotions'),
            value: isPromotionsEnabled,
            onChanged: (value) {
              setState(() {
                isPromotionsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}