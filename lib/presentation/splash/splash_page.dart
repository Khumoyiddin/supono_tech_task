import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../core/router/app_router_names.dart';
import '../../core/widgets/app_text_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // I see that the image should be 96px off the bottom, but that's considering
          // the safe area on iphone 16, but what about iphone SE that doesn't have home indicator
          // at the bottom? Therefore I decided to set the image height to full screen, due to the
          // lack of information on design, or rather the design isn't properly configured.
          image: AssetImage(PngAssets.splashBackground),
          fit: BoxFit.fill,
          // Also I mentioned that there is a radius on the top of the screen everywhere, initially
          // I thought it was meant to have a radius, but a carefully looking into the design,
          // came to conclusion that it is the frame.
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Spacer(),
            Container(
              height: 291,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Are you ready for\n your test?',
                    style: AppTextStyles.textStyle25,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 11),
                  Text(
                    'Start now by creating your profile and connect!',
                    style: AppTextStyles.splash16,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: AppTextButton(
                      text: 'Continue',
                      onPressed: () => context.push(AppRouterNames.onboarding),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
