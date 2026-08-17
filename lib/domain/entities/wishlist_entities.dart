class WishlistEntity {
  final int id;
  final String name;
  final double targetPrice;
  final double savingsAmount;

  WishlistEntity({
    required this.id,
    required this.name,
    required this.targetPrice,
    this.savingsAmount = 0,
  });
}
