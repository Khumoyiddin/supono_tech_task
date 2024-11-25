import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/network/shared_prefs.dart';
import '../../../l10n/l10n.dart';

class MyAccountPart extends StatefulWidget {
  const MyAccountPart({super.key});

  @override
  State<MyAccountPart> createState() => _MyAccountPartState();
}

class _MyAccountPartState extends State<MyAccountPart> {
  String? name;
  late String formattedBirthday;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).my_account, style: AppTextStyles.settings13),
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
                    S.of(context).username,
                    style: AppTextStyles.settings16,
                  ),
                  Text(
                    name ?? S.of(context).no_name,
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
                    S.of(context).birthday,
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
    );
  }

  void _loadValues() {
    final prefs = SharedPreferencesHelper.instance;
    name = prefs.getNickname();
    formattedBirthday = prefs.getBirthdayDate();
    setState(() {});
  }
}
