import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_paddings.dart';
import '../../core/app_text_styles.dart';
import '../../core/helpers/birthday_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? name;
  String formattedBirthday = '';

  final birthdayHelper = BirthdayHelper();
  bool _isAppUnlocked = false;

  final InAppReview _inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();
    _loadValues();

    final shouldShowUnlockDialog = GoRouter.of(context).state?.extra as bool?;
    if (shouldShowUnlockDialog == true) {
      Future.delayed(Duration(milliseconds: 300)).then((_) {
        _onUnlockPressed();
      });
    }
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('nickname');
    String day = prefs.getString('birthday_day') ?? '';
    String month = prefs.getString('birthday_month') ?? '';
    String year = prefs.getString('birthday_year') ?? '';
    formattedBirthday = birthdayHelper.formatBirthday(day, month, year);
    _isAppUnlocked = prefs.getBool('is_app_unlocked') ?? false;
    setState(() {});
  }

  Future<bool> _showUnlockDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Unlock App'),
              content: const Text('Are you sure you want to unlock the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _onUnlockPressed() async {
    bool unlockConfirmed = await _showUnlockDialog();
    if (unlockConfirmed) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('is_app_unlocked', true);
      setState(() => _isAppUnlocked = true);
    }
  }

  Future<void> _onRateUsPressed() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
    } else {
      log('In-app review is not available.');
    }
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
              Text('Settings', style: AppTextStyles.settings13),
              SizedBox(height: 7),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.darkPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!_isAppUnlocked) ...[
                      GestureDetector(
                        onTap: _onUnlockPressed,
                        child: Text(
                          'Unlock App',
                          style: AppTextStyles.settings16,
                        ),
                      ),
                      SizedBox(height: 14),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.purple,
                      ),
                      SizedBox(height: 12),
                    ],
                    GestureDetector(
                      onTap: _onRateUsPressed,
                      child: Text(
                        'Rate Us',
                        style: AppTextStyles.settings16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.darkPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Username',
                          style: AppTextStyles.settings16,
                        ),
                        Text(
                          name ?? 'No name',
                          style: AppTextStyles.settings15,
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: AppColors.purple,
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Birthday',
                          style: AppTextStyles.settings16,
                        ),
                        Text(
                          formattedBirthday,
                          style: AppTextStyles.settings15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
