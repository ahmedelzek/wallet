import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet/core/app_router/app_router.dart';

import 'core/di/injector.dart';
import 'core/resources/app_theme.dart';
import 'features/home_screen/settings_page/cubit/language_cubit.dart';
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
        BlocProvider(create: (_) => LocaleCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return ScreenUtilInit(
              designSize: Size(375, 812),
              child: MaterialApp.router(
                theme: AppTheme.lightTheme,
                title: 'Wallet',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: locale,
                builder: (context, child) {
                  return child!;
                },
                routerConfig: appRouter,
              ),
            );
          },
        ),
    );
  }
}
