import 'dart:convert';
import 'package:danceattix/env/config.dart';
import 'package:danceattix/helper/toast_message_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class PaymentController {

  Map<String,dynamic>? paymentIntentData;


  PaymentController(){
    Stripe.publishableKey = Config.publishableKey;
  }

  Future<void> makePayment({required String price}) async {
    try {
      paymentIntentData = await _createPaymentIntent(price, "USD");
      if (paymentIntentData != null) {
        String clientSecret = paymentIntentData!['client_secret'];

        if (kDebugMode) {
          print("Client Secret: $clientSecret");
        }

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            appearance: PaymentSheetAppearance(
                colors: PaymentSheetAppearanceColors(
                    background: Colors.white,
                    componentBackground: Colors.white,
                    componentText: Colors.black,
                    placeholderText: Colors.black
                )
            ),
            customFlow: false,
            billingDetails: const BillingDetails(
              name: '',
              email: 'ikramulhasantanvir@gmail.com',
            ),
            googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),

            merchantDisplayName: 'meal deal',
            paymentIntentClientSecret: clientSecret,
            style: ThemeMode.dark,
          ),
        );

        _displayPaymentSheet(price: price);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e\nStack trace: $s');
      }
    }
  }








  /// ===================================>>> hide =========================>>>
  Future<Map<String,dynamic>?> _createPaymentIntent(String amount,String currency) async {


    try {
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${Config.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      if (kDebugMode) {
        print("Payment Intent Response: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print("Error creating payment intent: $e");
      }
      return null;
    }

  }

  Future<PaymentIntent> stripeCheckPaymentIntentTransaction(String piId) async{

    try {
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(piId);
      if(kDebugMode){
        print("Payment Intent: $paymentIntent");
      }
      return paymentIntent;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching payment intent: $e');
      }
      rethrow;
    }
  }

  Future<void> _displayPaymentSheet({required String price}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      _retrieveTxnId(paymentIntent: paymentIntentData!['id'], price:price );
      if (kDebugMode) {
        print('Payment intent: $paymentIntentData');
      }
      paymentIntentData = null;
    } catch (e) {
      if (kDebugMode) {
        print("Error displaying payment sheet: $e");
      }
    }
  }

  Future<void> _retrieveTxnId({required String paymentIntent, required String price}) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.stripe.com/v1/charges?payment_intent=$paymentIntent'),
        headers: {
          "Authorization": "Bearer ${Config.secretKey}",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        String transactionId = data['data'][0]['balance_transaction'];

        if (kDebugMode) {
          print("Transaction Id: $transactionId");
          print("***********payment data: $data");
        }


        ToastMessageHelper.showToastMessage("Payment Success");
        Get.back();
      } else {
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String _calculateAmount(String amount) {
    final doubleAmount = double.tryParse(amount);
    if (doubleAmount != null) {
      return (doubleAmount * 100).toInt().toString();
    } else {
      throw const FormatException("Invalid amount format");
    }
  }
}
