import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../app_text_styles.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const AppTextButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        text,
        style: AppTextStyles.button,
      ),
    );
  }
}
