import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/core/customized_widgets/customized_app_snack_bar.dart';
import 'package:wallet/core/customized_widgets/customized_button.dart';
import 'package:wallet/core/customized_widgets/customized_text_fields.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/core/validators/validators_helper.dart';
import 'package:wallet/features/add_new_wishlist_screen/cubit/add_wishlist_cubit.dart';
import 'package:wallet/features/add_new_wishlist_screen/cubit/add_wishlist_state.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../../../core/di/injector.dart';

class AddNewWishlistScreen extends StatelessWidget {
  const AddNewWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (_)=>sl<AddWishlistCubit>(),
      child: BlocConsumer<AddWishlistCubit, AddWishlistState>(
        listener: (context, state){
          if(state is AddWishlistSuccessState){
            AppSnackBar.showSuccess(context, tr.wishlistAddedSuccess);
            context.pop();
          }else if(state is AddWishlistErrorState){
            AppSnackBar.showError(context, tr.wishlistAddedFailed);
          }
        },
        builder: (context, state) {
          final cubit = AddWishlistCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.wishListBackground,
            appBar: AppBar(
              title: Text(tr.addNewWish, style: TextStyle(color: AppColors.white)),
              backgroundColor: AppColors.violetBlue,
              iconTheme: IconThemeData(color: AppColors.white),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppWidth.w20,
                vertical: AppHeight.h20,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSize.s14)
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: AppWidth.w20,
                  vertical: AppHeight.h16,
                ),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomizedTextField(
                        hintText: tr.itemNameHint,
                        label: tr.itemName,
                        showBorder: true,
                        fillColor: AppColors.white,
                        controller: cubit.productNameController,
                        validator: Validators.requiredField,
                      ),
                      SizedBox(height: AppHeight.h20),
                      CustomizedTextField(
                        hintText: tr.amountHint,
                        label: tr.targetPrice,
                        showBorder: true,
                        prefixIcon: Icons.attach_money_sharp,
                        fillColor: AppColors.white,
                        validator: Validators.requiredField,
                      ),
                      SizedBox(height: AppHeight.h20),
                      CustomizedTextField(
                        hintText: tr.amountHint,
                        label: tr.initialSavings,
                        showBorder: true,
                        fillColor: AppColors.white,
                        prefixIcon: Icons.edit,
                      ),
                      SizedBox(height: AppHeight.h45),
                      CustomizedButton(
                        text: tr.createWish,
                        color: AppColors.violetBlue,
                        isLoading: state is AddWishlistLoadingState,
                        onTap: (){
                          cubit.addWishlist();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
