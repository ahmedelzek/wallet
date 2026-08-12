import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/core/customized_widgets/customized_app_snack_bar.dart';
import 'package:wallet/core/customized_widgets/customized_button.dart';
import 'package:wallet/core/customized_widgets/customized_text_fields.dart';
import 'package:wallet/core/customized_widgets/customized_type_drop_down.dart';
import 'package:wallet/core/di/injector.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/core/validators/validators_helper.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/features/update_transaction_screen/cubit/update_transaction_state.dart';

import '../../../l10n/app_translations.dart';
import 'cubit/update_transaction_cubit.dart';

class UpdateTransactionScreen extends StatelessWidget {

     const UpdateTransactionScreen({super.key, required this.transaction});
     final TransactionEntity transaction;

     @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (_) => sl<UpdateTransactionCubit>()..initialize(transaction),
      child: BlocConsumer<UpdateTransactionCubit, UpdateTransactionState>(
        listener: (context, state) {
          if (state is UpdateSuccess) {
            AppSnackBar.showSuccess(context, tr.transactionAddedSuccessfully);
            context.pop();
          } else if (state is UpdateError) {
            AppSnackBar.showError(context, tr.failedToUpdateTransaction);
          }
        },
        builder: (context, state) {
          final cubit = UpdateTransactionCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.mintWhite,
                elevation: 0,
                title: Text(
                  tr.updateTransaction,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: AppPadding.p50,
                  horizontal: AppPadding.p30,
                ),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    spacing: AppSize.s32,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomizedTypeDropDown(
                        selectedType: cubit.selectedType,
                        onChanged: (value) {
                          cubit.selectedType = value;
                        },
                      ),
                      CustomizedTextField(
                        hintText: tr.enterTitle,
                        controller: cubit.titleController,
                        validator: Validators.requiredField,
                      ),
                      CustomizedTextField(
                        hintText: tr.enterAmount,
                        controller: cubit.amountController,
                        validator: Validators.requiredField,
                        isNum: true,
                      ),
                      CustomizedTextField(
                        hintText: tr.enterDescriptionOrNote,
                        controller: cubit.noteController,
                        validator: Validators.requiredField,
                        isNote: true,
                      ),
                      CustomizedButton(
                        text: tr.updateTransaction,
                        color: AppColors.blue,
                        onTap: () {
                          if (cubit.selectedType == null) {
                            AppSnackBar.showError(
                              context,
                              tr.selectedTypeRequired,
                            );
                            return;
                          }
                          cubit.update();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
