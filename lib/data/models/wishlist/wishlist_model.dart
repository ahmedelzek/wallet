import 'package:hive/hive.dart';
import 'package:wallet/domain/entities/wishlist_entities.dart';

part 'wishlist_model.g.dart';

@HiveType(typeId: 1)
class WishlistModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double targetPrice;

  @HiveField(3)
  final double savingsAmount;

  WishlistModel({
    required this.id,
    required this.name,
    required this.targetPrice,
    this.savingsAmount = 0,
  });

  WishlistEntity toEntity() => WishlistEntity(
    id: id,
    name: name,
    targetPrice: targetPrice,
    savingsAmount: savingsAmount,
  );

  factory WishlistModel.fromEntity(WishlistEntity entity) {
    return WishlistModel(
      id: entity.id,
      name: entity.name,
      targetPrice: entity.targetPrice,
      savingsAmount: entity.savingsAmount,
    );
  }
}
