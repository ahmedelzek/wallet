abstract class AddWishlistState {}

class AddWishlistInitialState extends AddWishlistState {}

class AddWishlistLoadingState extends AddWishlistState {}

class AddWishlistErrorState extends AddWishlistState {
  final String error;
  AddWishlistErrorState({required this.error});
}

class AddWishlistSuccessState extends AddWishlistState {}
