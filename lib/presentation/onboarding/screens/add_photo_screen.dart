import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/router/app_router_names.dart';
import '../../../core/widgets/app_text_button.dart';

class AddPhotoScreen extends StatefulWidget {
  const AddPhotoScreen({super.key});

  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a nice photo \nof yourself',
          style: AppTextStyles.onboarding30,
        ),
        SizedBox(height: 58),
        AppTextButton(
          onPressed: () => context.push(AppRouterNames.camera),
          text: 'Take your first photo',
        ),
        SizedBox(height: 58),
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.grey95),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Make sure that your image', style: AppTextStyles.onboarding20),
                _descriptionItem('Shows your face clearly'),
                _descriptionItem('Yourself only, no group pic'),
                _descriptionItem('No fake pic, object or someone else'),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _descriptionItem(String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.done,
          color: AppColors.grey95,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          description,
          style: AppTextStyles.onboarding16,
        )
      ],
    );
  }
}
