import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';

class Billing extends StatefulWidget {
  const Billing({super.key});

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
      ),
      body: Center(
          child: Container(
        alignment: Alignment.center,
        child: const Webview(
          url: "http://localhost:52265/stripe/checkout.html",
          appName: 'Outdoor Money',
        ),
      )),
    );
  }
}
