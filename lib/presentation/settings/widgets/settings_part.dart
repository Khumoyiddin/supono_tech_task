import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/network/shared_prefs.dart';
import '../../../l10n/l10n.dart';

class SettingsPart extends StatefulWidget {
  const SettingsPart({super.key});

  @override
  State<SettingsPart> createState() => _SettingsPartState();
}

class _SettingsPartState extends State<SettingsPart> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).settings, style: AppTextStyles.settings13),
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
                    S.of(context).unlock_up,
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
                  S.of(context).rate_us,
                  style: AppTextStyles.settings16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _loadValues() async {
    final prefs = SharedPreferencesHelper.instance;
    _isAppUnlocked = prefs.getIsAppUnlocked();
    setState(() {});
  }

  Future<void> _onUnlockPressed() async {
    bool unlockConfirmed = await _showUnlockDialog();
    if (unlockConfirmed) {
      final prefs = SharedPreferencesHelper.instance;
      prefs.setIsAppUnlocked(true);
      setState(() => _isAppUnlocked = true);
    }
  }

  Future<bool> _showUnlockDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                S.of(context).unlock_up,
                style: AppTextStyles.settings16.copyWith(color: AppColors.black),
              ),
              content: Text(
                S.of(context).unlock_up_sure,
                style: AppTextStyles.settings13,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    S.of(context).no,
                    style: AppTextStyles.settings15.copyWith(color: AppColors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    S.of(context).yes,
                    style: AppTextStyles.settings15.copyWith(color: AppColors.black),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _onRateUsPressed() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
    } else {
      log('In-app review is not available.');
    }
  }
}
