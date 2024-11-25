import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';

class GenderButton extends StatelessWidget {
  final String genderType;
  final Function() onPressed;

  const GenderButton({super.key, required this.genderType, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 25),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(top: 16, bottom: 17),
          backgroundColor: AppColors.black.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: AppColors.grey95),
          ),
        ),
        child: Text(
          genderType,
          style: AppTextStyles.onboarding23,
        ),
      ),
    );
  }
}
