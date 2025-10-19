abstract class UpdateTransactionState{}

class UpdateInitial extends UpdateTransactionState {}

class UpdateLoading extends UpdateTransactionState{}

class UpdateSuccess extends UpdateTransactionState{

}
class UpdateError extends UpdateTransactionState{
  final String message;

  UpdateError(this.message);
}