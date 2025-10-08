import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';

import '../../../l10n/app_translations.dart';

class AddTransactionScreen extends StatefulWidget {
  static const String routeName = "add_transaction";

  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final Map<String, Color> _typeColors = {
    LocalizationService.instance.tr.income: AppColors.greenColor,
    LocalizationService.instance.tr.outgoing: AppColors.redColor,
    LocalizationService.instance.tr.savings: AppColors.blueColor,
    LocalizationService.instance.tr.debtPending: AppColors.orangeColor,
    LocalizationService.instance.tr.debtPaid: AppColors.orangeColor,
  };

  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            LocalizationService.instance.tr.addTransaction,
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
              color: AppColors.greenColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            children: [
            Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(LocalizationService.instance.tr.selectTransactionType),
              value: _selectedType,
              items:
              _typeColors.keys.map((String type) {
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
                  _selectedType = newValue!;
                });
              },
            ),
          ),
          const SizedBox(height: 35),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration:  InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                hintText: LocalizationService.instance.tr.enterAmount,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 35),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              minLines: 6,
              maxLines: 10,
              decoration:  InputDecoration(
                border: InputBorder.none,
                alignLabelWithHint: true,
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                hintText: LocalizationService.instance.tr.enterDescriptionOrNote,
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: WidgetStateProperty.all<Size>(
                const Size(double.infinity, 50),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                AppColors.greenColor,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(LocalizationService.instance.tr.addTransactionButton, style: Theme
                .of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
            ),)
            ],
          ),
        ),
      ),
    );
  }
}
