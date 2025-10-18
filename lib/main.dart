import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:wallet/features/home_screen/settings_page/cubit/delete_cubit.dart';
import 'core/di/injector.dart';
import 'core/resources/app_theme.dart';
import 'features/add_transaction_screen/add_transaction_screen.dart';
import 'features/add_transaction_screen/cubit/add_transactions_cubit.dart';
import 'features/home_screen/home_page/cubit/transaction_cubit.dart';
import 'features/home_screen/home_screen.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddTransactionCubit>(
          create: (_) => sl<AddTransactionCubit>(),
        ),
        BlocProvider<TransactionCubit>(
          create: (_) => sl<TransactionCubit>()..loadTransactions(),
        ),
        BlocProvider<DeleteAllCubit>(
          create: (_) => sl<DeleteAllCubit>(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
