import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:mad_pay/mad_pay.dart' as madpay;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String errorData = 'Sin identificar';

  Pay payclient = Pay.withAssets(['sample_payment_configuration.json']);

  defaultOnPressed(List<PaymentItem> paymentItems) async {
    print('-------------------------------');
    try {
      final result =
          await payclient.showPaymentSelector(paymentItems: paymentItems);

      print('##########################################');
      print(result);
      print('##########################################');
      // onPaymentResult(result);
    } catch (error) {
      print('ee##########################################');
      print(error);
      print('##########################################');
      // onError?.call(error);
    }
  }

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
              Text('Aqui deberia ir el boton de google pay natural'),
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
              Divider(),
              Text('Aqui deberia ir el boton de google pay forzado'),
              MaterialButton(
                onPressed: () async {
                  await defaultOnPressed(_paymentItems);
                },
                child: Text(
                  'Demo boton pay',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
              ),
              Divider(),
              Text('Segundo intento con otra dependencia'),
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                child: madpay.GooglePayButton(
                  childIfUnavailable: Text('ERROR'),
                  type: madpay.GooglePayButtonType.plain,
                  request: madpay.PaymentRequest.google(
                    google: googleParameters,
                    currencyCode: 'USD',
                    countryCode: 'US',
                    paymentItems: <madpay.PaymentItem>[
                      madpay.PaymentItem(name: 'T-Shirt', price: 2.98),
                      madpay.PaymentItem(name: 'Trousers', price: 15.24),
                    ],
                  ),
                  onPaymentResult: (madpay.PaymentResponse req) {
                    print('##########################################');
                    print(req);
                    print('##########################################');
                    // ...
                  },
                  onError: (Object e) {
                    print('sss##########################################');
                    print(e);
                    print('##########################################');
                    // ...
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final madpay.GoogleParameters googleParameters = madpay.GoogleParameters(
    gatewayName: 'example',
    gatewayMerchantId: 'exampleGatewayMerchantId',
    merchantId: 'BCR2DN4TWC72BOKM',
    merchantName: 'CURSOSPARAPROGRAMADORES',
    cardParameters: madpay.CardParameters(
      billingAddressRequired: true,
      billingAddressParameters: madpay.BillingAddressParameters(
        billingFormat: madpay.BillingFormat.full,
        phoneNumberRequired: true,
      ),
    ),
    transactionInfo: madpay.TransactionInfo(
      totalPriceLabel: 'Test',
      checkoutOption: madpay.CheckoutOption.completeImmediatePurchase,
    ),
    shippingAddressRequired: true,
    shippingAddressParameters: madpay.ShippingAddressParameters(
      phoneNumberRequired: true,
    ),
  );

  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
    print('##########################################');
    print(paymentResult);
    print('##########################################');
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
    print('www##########################################');
    print(paymentResult);
    print('##########################################');
  }
}
