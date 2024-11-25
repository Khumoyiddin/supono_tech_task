import 'package:flutter/material.dart';

import '../../../core/app_text_styles.dart';
import '../widgets/gender_button.dart';

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
