import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/features/add_transaction_screen/add_transaction_screen.dart';
import 'package:wallet/features/home_screen/home_screen.dart';
import 'package:wallet/features/update_transaction_screen/update_transaction_screen.dart';

import 'app_router_keys.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRouterKeys.home,
  routes: [
    GoRoute(
      path: AppRouterKeys.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: AppRouterKeys.editTransaction,
      builder: (context, state) => UpdateTransactionScreen(),
    ),
    GoRoute(
      path: AppRouterKeys.addTransaction,
      builder: (context, state) => AddTransactionScreen(),
    ),
  ],
);
