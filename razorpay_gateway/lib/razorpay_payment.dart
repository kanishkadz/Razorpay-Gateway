import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPage extends StatefulWidget {
  const RazorPayPage({super.key});

  @override
  State<RazorPayPage> createState() => _RazorPayPageState();
}

class _RazorPayPageState extends State<RazorPayPage> {
  late Razorpay _razorpay;
  TextEditingController amtController = new TextEditingController();

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_1DP5mm0lF5G5ag',
      'amount': amount,
      'name': 'Kanishka Anand',
      'prefill': {'contact': '99xxxxxxxx', 'email': 'kanishkaadz@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Fail " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image.network(
              'data:image/png;base64,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',
              height: 100,
              width: 300,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome to Razorpay Gateway Integration",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Enter amount to be paid',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15)),
                controller: amtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Amount to be paid';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (amtController.text.toString().isNotEmpty) {
                  setState(() {
                    int amount = int.parse(amtController.text.toString());
                    openCheckout(amount);
                  });
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Make Payment'),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
