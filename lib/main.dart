import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:wallet/features/home/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/di/injector.dart';
import 'core/resources/app_theme.dart';
import 'features/home/add_transaction_screen/add_transaction_screen.dart';
import 'l10n/app_translations.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      title: 'Wallet',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        LocalizationService.instance.update(context);
        return child!;
      },
      locale: const Locale('en'),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddTransactionScreen.routeName: (context) => AddTransactionScreen(),
      },
    );
  }
}