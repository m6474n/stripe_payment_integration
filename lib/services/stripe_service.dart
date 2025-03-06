import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  // private constructure
  StripeService._();

// Ensure that there will be single instance ever throughout the app
  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPayemntIntent(10, 'usd');

      if(paymentIntentClientSecret==null)return;
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "Deversol"
      ));
      _processPayment();


    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _processPayment()async{

    try{
      await Stripe.instance.presentPaymentSheet();
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<String?> _createPayemntIntent(int amount, String currency)async{
    try {
      final Dio dio = Dio();
      Map<String,dynamic> data= {
        'amount': _calculatePayment(amount),
        'currency': currency
      };
     var response = await dio.post('https://api.stripe.com/v1/payment_intents',
     data: data, options: Options(contentType: Headers.formUrlEncodedContentType, headers: {
        "Authorization": "Bearer ${dotenv.env['STRIPE_PRIVATE_KEY']}",
        "Content-Type": 'application/x-www-form-urlencoded'
      }));

    if(response.data!=null){
      debugPrint(response.data.toString());
      return response.data['client_secret'];
    }else{
      return null;
    }

    } catch (e) {
       debugPrint(e.toString());
    }
return null;
  }
  String _calculatePayment(int amount){
   final calculatedAmount = amount *100;
   return calculatedAmount.toString();
  }
}
