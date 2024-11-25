import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/network/shared_prefs.dart';
import '../../../l10n/l10n.dart';
import '../../app_widget.dart';

class LanguagePart extends StatefulWidget {
  const LanguagePart({super.key});

  @override
  State<LanguagePart> createState() => _LanguagePartState();
}

class _LanguagePartState extends State<LanguagePart> {
  late String _currentLang = Localizations.localeOf(context).languageCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).language, style: AppTextStyles.settings13),
        SizedBox(height: 7),
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
                    S.of(context).language,
                    style: AppTextStyles.settings16,
                  ),
                  Text(
                    S.of(context).current_language,
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
              GestureDetector(
                onTap: _changeLanguage,
                child: Text(
                  S.of(context).change_language,
                  style: AppTextStyles.settings16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _changeLanguage() async {
    final prefs = SharedPreferencesHelper.instance;
    final newLang = _currentLang == LanguageCode.en.name ? LanguageCode.ar : LanguageCode.en;
    await prefs.setLanguageCode(newLang);
    if (mounted) {
      AppWidget.of(context)?.setLocale(newLang);
    }
    setState(() => _currentLang = newLang.name);
  }
}
