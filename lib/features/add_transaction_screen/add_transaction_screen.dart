import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/customized_widgets/customized_text_fields.dart';
import 'package:wallet/core/customized_widgets/customized_type_drop_down.dart';
import 'package:wallet/core/di/injector.dart';
import 'package:wallet/core/resources/app_colors.dart';
import '../../../domain/entities/transactions_entities.dart';
import '../../../domain/use_cases/add_transaction_usecase.dart';
import '../../../l10n/app_translations.dart';
import '../../core/resources/transaction_types.dart';
import '../home_screen/home_page/cubit/transaction_cubit.dart';
import 'cubit/add_transaction_state.dart';
import 'cubit/add_transactions_cubit.dart';

class AddTransactionScreen extends StatefulWidget {
  static const String routeName = "add_transaction";

  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  TransactionType? _selectedType;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTransactionCubit(sl<AddTransactionUseCase>()),
      child: BlocConsumer<AddTransactionCubit, AddTransactionState>(
        listener: (context, state) {
          if (state is AddTransactionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(LocalizationService.instance.tr.transactionAddedSuccessfully)),
            );
            _titleController.clear();
            _amountController.clear();
            _noteController.clear();
            setState(() => _selectedType = null);
          } else if (state is AddTransactionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.mintWhite,
                elevation: 0,
                title: Text(
                  LocalizationService.instance.tr.addTransaction,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                child: Column(
                  spacing: 35,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  customizedTypeDropDown(_selectedType, (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  }),
                    customizedTitleTextFormField(_titleController),
                    customizedAmountTextFormField(_amountController),
                    customizedDescriptionTextFormField(_noteController),
                    ElevatedButton(
                      onPressed: state is AddTransactionLoading
                          ? null
                          : ()  {
                        if (_selectedType == null ||
                            _titleController.text.isEmpty ||
                            _amountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(
                                LocalizationService.instance.tr.addRequiredFields,
                              ),
                            ),
                          );
                          return;
                        }
                        final transaction = TransactionEntity(
                          id: DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF,
                          title: _titleController.text,
                          amount: double.tryParse(_amountController.text) ?? 0.0,
                          note: _noteController.text.isEmpty
                              ? null
                              : _noteController.text,
                          type: _selectedType!.key,
                        );
                         context
                            .read<AddTransactionCubit>()
                            .addTransaction(transaction);

                        context.read<TransactionCubit>().loadTransactions();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: state is AddTransactionLoading
                          ? const CircularProgressIndicator(color: AppColors.green)
                          : Text(
                        LocalizationService.instance.tr.addTransactionButton,
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
