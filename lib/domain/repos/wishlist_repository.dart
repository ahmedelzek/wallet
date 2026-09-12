import 'package:wallet/domain/entities/wishlist_entities.dart';

abstract class WishlistRepository {
  Future<List<WishlistEntity>> getAllWishlist();

  Future<void> addWishlist(WishlistEntity wishlistItem);

  Future<void> deleteWishlist(int id);

  Future<void> updateWishlist(WishlistEntity wishlistItem);

  Future<double> getAvailableMoney();

  Future<double> getTotalWishlist();

  Future<double> getTotalAmountNeeded();
}
