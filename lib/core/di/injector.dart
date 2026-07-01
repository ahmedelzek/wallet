import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/features/home_screen/settings_page/cubit/settings_cubit.dart';
import 'package:wallet/features/home_screen/transactions_page/cubit/transactions_cubit.dart';

import '../../data/models/transactions_model.dart';
import '../../data/repos/transactions_repository_impl.dart';
import '../../domain/repos/transactions_repository.dart';
import '../../domain/use_cases/add_transaction_usecase.dart';
import '../../domain/use_cases/delete_all_trasnactions_usecase.dart';
import '../../domain/use_cases/delete_transaction_by_id_usecase.dart';
import '../../domain/use_cases/get_income_sum_usecase.dart';
import '../../domain/use_cases/get_net_balance_usecase.dart';
import '../../domain/use_cases/get_outgoing_sum_usecase.dart';
import '../../domain/use_cases/get_transactions_by_type_usecase.dart';
import '../../domain/use_cases/get_transactions_usecase.dart';
import '../../domain/use_cases/search_transaction_usecase.dart';
import '../../domain/use_cases/update_transaction_usecase.dart';
import '../../features/add_transaction_screen/cubit/add_transactions_cubit.dart';
import '../../features/home_screen/home_page/cubit/home_cubit.dart';
import '../../features/update_transaction_screen/cubit/update_transaction_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //hive
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  final transactionBox = await Hive.openBox<TransactionModel>('transactions');
  sl.registerLazySingleton<Box<TransactionModel>>(() => transactionBox);

  // repos
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(box: sl()),
  );

  // use_cases
  sl.registerLazySingleton(() => AddTransactionUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTransactionUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchTransactionUseCase(repository: sl()));
  sl.registerLazySingleton(
    () => GetTransactionsByTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => DeleteAllTransactionsUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => DeleteTransactionByIdUseCase(repository: sl()),
  );
  sl.registerLazySingleton(() => GetTransactionsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetNetBalanceUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetIncomeSumUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetOutgoingSumUseCase(repository: sl()));

  // cubits
  sl.registerFactory(() => AddTransactionCubit(sl<AddTransactionUseCase>()));
  sl.registerFactory(
    () => UpdateTransactionCubit(sl<UpdateTransactionUseCase>()),
  );
  sl.registerFactory(() => SettingsCubit(deleteAllTransactionsUseCase: sl()));
  sl.registerFactory(() => HomeCubit(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => TransactionsCubit(getTransactionsUseCase: sl()));
}
