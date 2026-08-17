import 'package:hive/hive.dart';

import '../../../domain/entities/transactions_entities.dart';
part 'transactions_model.g.dart';

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String? note;

  @HiveField(4)
  String type;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    this.note,
    required this.type,
  });

  TransactionEntity toEntity() => TransactionEntity(
    id: id,
    title: title,
    amount: amount,
    note: note,
    type: type,
  );

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      note: entity.note,
      type: entity.type,
    );
  }
}
