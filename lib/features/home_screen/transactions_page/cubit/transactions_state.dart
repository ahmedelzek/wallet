abstract class TransactionsState {}

class TransactionsInitialState extends TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsErrorState extends TransactionsState {
  final String error ;
  TransactionsErrorState({required this.error});
}

class TransactionsSuccessState extends TransactionsState {}