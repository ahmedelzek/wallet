class TransactionEntity {
  final int id;
  final String title;
  final double amount;
  final String? note;
  final String type;

  TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    this.note,
    required this.type,
  });
}