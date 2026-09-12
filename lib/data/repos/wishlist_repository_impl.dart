import 'package:hive/hive.dart';
import 'package:wallet/data/models/wishlist/wishlist_model.dart';
import 'package:wallet/domain/entities/wishlist_entities.dart';
import 'package:wallet/domain/repos/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final Box<WishlistModel> box;

  WishlistRepositoryImpl({required this.box});

  @override
  Future<void> addWishlist(WishlistEntity wishlistItem) async {
    final model = WishlistModel.fromEntity(wishlistItem);
    await box.put(model.id, model);
  }

  @override
  Future<void> updateWishlist(WishlistEntity wishlistItem) async {
    final model = WishlistModel.fromEntity(wishlistItem);
    await box.put(model.id, model);
  }

  @override
  Future<void> deleteWishlist(int id) async {
    await box.delete(id);
  }

  @override
  Future<List<WishlistEntity>> getAllWishlist() async{
    final models = box.values.toList();
    return models.map((element) => element.toEntity()).toList();
  }

  @override
  Future<double> getAvailableMoney() {
    // TODO: implement getAvailableMoney
    throw UnimplementedError();
  }

  @override
  Future<double> getTotalAmountNeeded() {
    // TODO: implement getTotalAmountNeeded
    throw UnimplementedError();
  }

  @override
  Future<double> getTotalWishlist() {
    // TODO: implement getTotalWishlist
    throw UnimplementedError();
  }
}
