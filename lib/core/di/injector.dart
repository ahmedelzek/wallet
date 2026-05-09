import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
import '../../features/home_screen/debts_page/cubit/debts_cubit.dart';
import '../../features/home_screen/home_page/cubit/transaction_cubit.dart';
import '../../features/home_screen/settings_page/cubit/delete_cubit.dart';
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
    () => DeleteAllTransactionsUseCase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton(
    () => DeleteTransactionByIdUseCase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton(
    () => GetTransactionsUseCase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton(
    () => GetNetBalanceUseCase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton(
    () => GetIncomeSumUseCase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton(
    () => GetOutgoingSumUseCase(sl<TransactionRepository>()),
  );

  // cubits
  sl.registerFactory(() => AddTransactionCubit(sl<AddTransactionUseCase>()));
  sl.registerFactory(
    () => UpdateTransactionCubit(sl<UpdateTransactionUseCase>()),
  );
  sl.registerFactory(() => DeleteAllCubit(sl<DeleteAllTransactionsUseCase>()));
  sl.registerFactory(() => DebtsCubit(sl<GetTransactionsByTypeUseCase>()));
  sl.registerFactory(
    () => HomeCubit(
      sl<GetTransactionsUseCase>(),
      sl<SearchTransactionUseCase>(),
      sl<GetIncomeSumUseCase>(),
      sl<GetOutgoingSumUseCase>(),
      sl<GetNetBalanceUseCase>(),
      sl<DeleteTransactionByIdUseCase>(),
    ),
  );
}
