import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/app_colors.dart';

Widget buttonContainer(Color containerColor, Color iconColor, IconData icon) {
  return Container(
    height: 70,
    width: 70,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(
      icon,
      color: iconColor,
      size: 32,
    ),
  );
}

Widget balanceCard(String title, String amount, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.transparentGreen,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.mintWhite,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$amount  EGP",
              style: TextStyle(
                color: AppColors.mintWhite,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}