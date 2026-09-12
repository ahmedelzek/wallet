import 'package:wallet/domain/entities/wishlist_entities.dart';
import 'package:wallet/domain/repos/wishlist_repository.dart';

class AddNewWishlistUseCase {
  final WishlistRepository repo;

  const AddNewWishlistUseCase({required this.repo});

  Future<void> call({required WishlistEntity wishlist}) async =>
      await repo.addWishlist(wishlist);
}
