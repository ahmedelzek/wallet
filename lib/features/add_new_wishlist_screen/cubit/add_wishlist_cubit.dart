import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/entities/wishlist_entities.dart';
import 'package:wallet/domain/use_cases/wishlist_use_cases/add_new_wishlist_use_case.dart';
import 'package:wallet/features/add_new_wishlist_screen/cubit/add_wishlist_state.dart';

class AddWishlistCubit extends Cubit<AddWishlistState> {
  final AddNewWishlistUseCase addNewWishlistUseCase;

  AddWishlistCubit({required this.addNewWishlistUseCase})
    : super(AddWishlistInitialState());

  static AddWishlistCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();
  final TextEditingController initialSavedController = TextEditingController();

  Future<void> addWishlist() async {
    if (formKey.currentState?.validate() == false) return;

    emit(AddWishlistLoadingState());
    try {
      final wishlist = WishlistEntity(
        id: DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF,
        name: productNameController.text,
        targetPrice: double.tryParse(totalPriceController.text) ?? 00,
        savingsAmount: double.tryParse(initialSavedController.text)
      );
      await addNewWishlistUseCase.call(wishlist: wishlist);
      emit(AddWishlistSuccessState());
    } catch (e) {
      emit(AddWishlistErrorState(error: e.toString()));
    }
  }
}
