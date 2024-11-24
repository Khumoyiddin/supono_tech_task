import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_paddings.dart';
import '../../../core/app_text_styles.dart';

class OnboardingFrame extends StatelessWidget {
  final Widget child;
  final int frameIndex;
  final Function() onBackPressed;

  const OnboardingFrame({
    super.key,
    required this.child,
    required this.frameIndex,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(
          height: screenHeight,
          JpgAssets.onboardingBackground,
          alignment: Alignment(-1 + (frameIndex * 2 / 3), 0),
          fit: BoxFit.cover,
        ),
        Container(
          padding: AppPaddings.horizontalTop,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (frameIndex == 0) {
                          context.pop();
                        } else {
                          FocusScope.of(context).unfocus();
                          // Setting a little delay to prevent issues while the keyboard is being closed
                          await Future.delayed(Duration(milliseconds: 100));
                          onBackPressed();
                        }
                      },
                      child: SvgPicture.asset(
                        frameIndex == 0 ? SvgAssets.icCancel : SvgAssets.icBack,
                      ),
                    ),
                    CircularPercentageIndicator(percentage: (frameIndex + 1) * 100 / 4),
                  ],
                ),
                SizedBox(height: 49),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CircularPercentageIndicator extends StatelessWidget {
  final double percentage;

  const CircularPercentageIndicator({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 44,
          height: 44,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: Duration(milliseconds: 500),
            builder: (context, value, child) {
              return CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 1,
                backgroundColor: AppColors.grey95,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              );
            },
          ),
        ),
        Text(
          '${percentage.toInt()}%',
          style: AppTextStyles.onboarding14,
        ),
      ],
    );
  }
}
