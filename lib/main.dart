import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:wallet/features/home/home_screen.dart';

import 'features/home/add_transaction_screen/add_transaction_screen.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 2));

  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: AddTransactionScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddTransactionScreen.routeName: (context) => AddTransactionScreen(),
      },
    );
  }
}