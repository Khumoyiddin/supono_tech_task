import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/router/app_router_names.dart';
import '../../../core/widgets/app_text_button.dart';

class CameraNotFoundState extends StatelessWidget {
  const CameraNotFoundState({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          const Icon(Icons.camera_alt, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Text(
              'No camera found. \nPlease try on a physical device.',
              textAlign: TextAlign.center,
              style: AppTextStyles.settings16.copyWith(color: AppColors.grey95),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: AppTextButton(
              onPressed: () => context.push(AppRouterNames.photoPreview),
              text: 'Continue to photo preview page.',
            ),
          ),
          SizedBox(height: 17),
        ],
      ),
    );
  }
}
