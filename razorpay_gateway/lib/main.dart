import 'package:flutter/material.dart';
import 'package:razorpay_gateway/razorpay_payment.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Razorpay Payment Gateway',
      home: const RazorPayPage(),
    );
  }
}
