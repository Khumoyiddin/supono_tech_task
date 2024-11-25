import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/helpers/app_input_decoration_extension.dart';

class NicknameTextField extends StatelessWidget {
  final TextEditingController controller;

  const NicknameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        cursorColor: AppColors.grey95,
        style: AppTextStyles.textStyle25,
        keyboardType: TextInputType.text,
        decoration: AppInputDecoration.withCustomBorder(),
      ),
    );
  }
}
