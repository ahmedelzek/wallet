import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/customized_widgets/app_snack_bar_manager.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';
import 'package:wallet/l10n/app_translations.dart';
import '../../core/di/injector.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/transaction_types.dart';
import '../../domain/use_cases/update_transaction_usecase.dart';
import '../home_screen/home_page/cubit/home_cubit.dart';
import 'cubit/update_transaction_cubit.dart';
import 'cubit/update_transaction_state.dart';

class UpdateTransactionScreen extends StatefulWidget {
  static const String routeName = "update_transaction";

  const UpdateTransactionScreen({super.key});

  @override
  State<UpdateTransactionScreen> createState() =>
      _UpdateTransactionScreenState();
}

class _UpdateTransactionScreenState extends State<UpdateTransactionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  TransactionType? _selectedType;

  //late TransactionEntity transaction;
  bool _isInitialized = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr =LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (_) => UpdateTransactionCubit(sl<UpdateTransactionUseCase>()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(tr.updateTransaction,
            style: TextStyle(color: AppColors.blue),
          ),
        ),
        body: BlocConsumer<UpdateTransactionCubit, UpdateTransactionState>(
          listener: (context, state) {
            if (state is UpdateSuccess) {
              AppSnackBar.showSuccess(context, tr.updatedSuccess);
              context.read<HomeCubit>().loadTransactions();
              Navigator.pop(context);
            } else if (state is UpdateError) {
              AppSnackBar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 35,
                  children: [
                   /* CustomizedTypeDropDown(_selectedType, (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    }),*/

                    ElevatedButton(
                      onPressed: state is UpdateLoading
                          ? null
                          : () {
                        if (_selectedType == null ||
                            _titleController.text.isEmpty ||
                            _amountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(
                                tr.addRequiredFields,
                              ),
                            ),
                          );
                          return;
                        }
                        final updatedTransaction = TransactionEntity(
                          id: 00,
                          title: _titleController.text,
                          amount: double.tryParse(_amountController.text) ?? 0.0,
                          note: _noteController.text.isEmpty
                              ? null
                              : _noteController.text,
                          type: _selectedType!.key,
                        );
                        context
                            .read<UpdateTransactionCubit>()
                            .updateTransaction(updatedTransaction);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: AppColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: state is UpdateLoading
                          ? const CircularProgressIndicator(color: AppColors.white)
                          : Text(
                        tr.saveChanges,
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}