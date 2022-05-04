import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String errorData = 'Sin identificar';

  @override
  Widget build(BuildContext context) {
    print('==>prueba de build');
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.min,

            children: [
              Text('Aqui deberia ir el boton de applePay'),
              Container(
                color: Colors.orange,
                padding: EdgeInsets.all(45),
                child: ApplePayButton(
                  paymentConfigurationAsset:
                      'sample_payment_configuration.json',
                  paymentItems: _paymentItems,
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: onApplePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onError: (error) {
                    print('###### $error');
                    errorData = error.toString();
                    setState(() {});
                  },
                  childOnError: Text('ERROR =>$errorData<='),
                ),
              ),
              Text('Aqui deberia ir el boton de google pay'),
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(45),
                child: GooglePayButton(
                  paymentConfigurationAsset:
                      'sample_payment_configuration.json',
                  paymentItems: _paymentItems,
                  style: GooglePayButtonStyle.black,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onError: (error) {
                    print('###### $error');
                    errorData = error.toString();
                  },
                  childOnError: Text('ERROR =>$errorData<='),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }
}
