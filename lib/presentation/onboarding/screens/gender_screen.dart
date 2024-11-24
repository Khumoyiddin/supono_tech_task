import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';

class GenderScreen extends StatelessWidget {
  final Function() onPressed;

  const GenderScreen({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Which gender do \nyou identify as?',
          style: AppTextStyles.onboarding30,
        ),
        SizedBox(height: 14),
        SizedBox(
          width: 278,
          child: Text(
            'Your gender helps us find the right matches for you.',
            style: AppTextStyles.onboarding15,
          ),
        ),
        SizedBox(height: 40),
        GenderButton(genderType: 'Male', onPressed: onPressed),
        GenderButton(genderType: 'Female', onPressed: onPressed),
        GenderButton(genderType: 'Other', onPressed: onPressed),
      ],
    );
  }
}

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
