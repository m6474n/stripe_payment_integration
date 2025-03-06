import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stripe_payment_integration/services/stripe_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(dotenv.env['APP_NAME'].toString()),),
    body: Center(child: ElevatedButton(onPressed: (){
StripeService.instance.makePayment();
    }, child: Text("Purchase")),),
    );
  }
}