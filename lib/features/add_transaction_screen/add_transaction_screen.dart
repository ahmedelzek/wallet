import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/core/customized_widgets/customized_app_snack_bar.dart';
import 'package:wallet/core/customized_widgets/customized_button.dart';
import 'package:wallet/core/customized_widgets/customized_text_fields.dart';
import 'package:wallet/core/customized_widgets/customized_type_drop_down.dart';
import 'package:wallet/core/di/injector.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/validators/validators_helper.dart';

import '../../../l10n/app_translations.dart';
import 'cubit/add_transaction_state.dart';
import 'cubit/add_transactions_cubit.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr;
    return BlocProvider(
      create: (_) => sl<AddTransactionCubit>(),
      child: BlocConsumer<AddTransactionCubit, AddTransactionState>(
        listener: (context, state) {
          if (state is AddTransactionSuccess) {
            AppSnackBar.showSuccess(context, tr.transactionAddedSuccessfully);
            context.pop();
          } else if (state is AddTransactionFailure) {
            AppSnackBar.showError(context, tr.failedToUpdateTransaction);
          }
        },
        builder: (context, state) {
          final cubit = AddTransactionCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.mintWhite,
                elevation: 0,
                title: Text(
                  tr.addTransaction,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 30,
                ),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    spacing: 35,
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
                        text: tr.addTransaction,
                        onTap: () {
                          if (cubit.selectedType == null) {
                            AppSnackBar.showError(
                              context,
                              "selected type is required",
                            );
                            return;
                          }
                          cubit.addTransaction();
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
