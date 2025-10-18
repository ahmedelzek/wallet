import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/domain/use_cases/delete_all_trasnactions_usecase.dart';
import 'package:wallet/domain/use_cases/delete_transaction_by_id_usecase.dart';
import 'package:wallet/domain/use_cases/get_income_sum_usecase.dart';
import 'package:wallet/domain/use_cases/get_net_balance_usecase.dart';
import 'package:wallet/domain/use_cases/get_outgoing_sum_usecase.dart';
import 'package:wallet/features/add_transaction_screen/cubit/add_transactions_cubit.dart';
import 'package:wallet/features/home_screen/settings_page/cubit/delete_cubit.dart';

import '../../data/models/transactions_model.dart';
import '../../data/repos/transactions_repository_impl.dart';
import '../../domain/repos/transactions_repository.dart';
import '../../domain/use_cases/add_transaction_usecase.dart';
import '../../domain/use_cases/get_transactions_usecase.dart';
import '../../features/home_screen/home_page/cubit/transaction_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());

  final transactionBox = await Hive.openBox<TransactionModel>('transactions');

  sl.registerLazySingleton<Box<TransactionModel>>(() => transactionBox);

  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl<Box<TransactionModel>>()),
  );

  sl.registerLazySingleton(
    () => AddTransactionUseCase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton(
    () => AddTransactionCubit(sl<AddTransactionUseCase>()),
  );
  sl.registerLazySingleton(
    () => DeleteAllTransactionsUseCase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton(
    () => DeleteAllCubit(sl<DeleteAllTransactionsUseCase>()),
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
  sl.registerFactory(
    () => TransactionCubit(
      sl<GetTransactionsUseCase>(),
      sl<GetIncomeSumUseCase>(),
      sl<GetOutgoingSumUseCase>(),
      sl<GetNetBalanceUseCase>(),
      sl<DeleteTransactionByIdUseCase>(),
    ),
  );
}
