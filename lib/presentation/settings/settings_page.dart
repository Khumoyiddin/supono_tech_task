import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_paddings.dart';
import 'widgets/language_part.dart';
import 'widgets/my_account_part.dart';
import 'widgets/settings_part.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then(
      (_) {
        // Uncomment to test FirebaseCrashlytics
        // FirebaseCrashlytics.instance.crash();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.horizontalTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(SvgAssets.icBack),
              ),
              SizedBox(height: 30),
              SettingsPart(),
              SizedBox(height: 24),
              MyAccountPart(),
              SizedBox(height: 24),
              LanguagePart(),
            ],
          ),
        ),
      ),
    );
  }
}
