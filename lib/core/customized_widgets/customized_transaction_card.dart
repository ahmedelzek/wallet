import 'package:flutter/material.dart';
import 'package:wallet/domain/entities/transactions_entities.dart';

import '../resources/app_colors.dart';

class CustomizedTransactionCard extends StatefulWidget {
  final TransactionEntity transaction;
  const CustomizedTransactionCard({super.key, required this.transaction});

  @override
  State<CustomizedTransactionCard> createState() => _CustomizedTransactionCardState();
}

class _CustomizedTransactionCardState extends State<CustomizedTransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(12),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGrey2,
        borderRadius: BorderRadius.circular(10),
      ),
      child:Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            width: 4,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.transaction.title),
                Text(widget.transaction.amount.toString()),
                Text(widget.transaction.type),
              ],
            ),
          )
        ],
      ) ,
    );
  }
}
