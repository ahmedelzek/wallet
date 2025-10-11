import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/di/injector.dart';
import '../../../domain/entities/transactions_entities.dart';
import '../../../domain/use_cases/add_transaction_usecase.dart';
import '../../../l10n/app_translations.dart';
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

  String? _selectedType;

  final Map<String, Color> _typeColors = {
    LocalizationService.instance.tr.income: AppColors.green,
    LocalizationService.instance.tr.outgoing: AppColors.red,
    LocalizationService.instance.tr.savings: AppColors.blue,
    LocalizationService.instance.tr.debtPending: AppColors.orange,
    LocalizationService.instance.tr.debtPaid: AppColors.orange,
  };

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
              const SnackBar(content: Text('Transaction added successfully')),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(LocalizationService.instance.tr.selectTransactionType),
                        value: _selectedType,
                        items: _typeColors.keys.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type,
                              style: TextStyle(
                                color: _typeColors[type],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedType = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 35),

                    // 🏷️ Title field
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: LocalizationService.instance.tr.enterTitle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: LocalizationService.instance.tr.enterAmount,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _noteController,
                        minLines: 6,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          LocalizationService.instance.tr.enterDescriptionOrNote,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: state is AddTransactionLoading
                          ? null
                          : () {
                        if (_selectedType == null ||
                            _titleController.text.isEmpty ||
                            _amountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please fill all required fields',
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
                          type: _selectedType!,
                        );
                        context
                            .read<AddTransactionCubit>()
                            .addTransaction(transaction);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: state is AddTransactionLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        LocalizationService.instance.tr.addTransactionButton,
                        style: const TextStyle(color: Colors.white),
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
