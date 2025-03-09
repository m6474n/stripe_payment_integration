import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment_integration/home_screen.dart';

void main() async{
 
  runApp(const MyApp());
}

Future<void> _setup()async{
 await WidgetsFlutterBinding.ensureInitialized()
; await dotenv.load(fileName: '.env');
 Stripe.publishableKey= dotenv.env['STRIPE_PUBLIC_KEY']!; 
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen()
    );
  }
}
