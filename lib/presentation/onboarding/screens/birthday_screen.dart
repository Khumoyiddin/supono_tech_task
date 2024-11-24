import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/helpers/app_input_decoration_extension.dart';

class BirthdayScreen extends StatefulWidget {
  final Function() onPressed;

  const BirthdayScreen({super.key, required this.onPressed});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> with AutomaticKeepAliveClientMixin {
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  final _dayNode = FocusNode();
  final _monthNode = FocusNode();
  final _yearNode = FocusNode();

  bool showErrorMessage = false;

  Future<void> _saveBirthday() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday_day', _dayController.text.trim());
    await prefs.setString('birthday_month', _monthController.text.trim());
    await prefs.setString('birthday_year', _yearController.text.trim());
  }

  bool _isInputValid() {
    return _dayController.text.isNotEmpty &&
        _monthController.text.isNotEmpty &&
        _yearController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When’s your \nbirthday?',
          style: AppTextStyles.onboarding30,
        ),
        SizedBox(height: showErrorMessage == true ? 20 : 58),
        Row(
          children: [
            BirthdayTextField(
              index: 0,
              fieldName: 'Date',
              focusNode: _dayNode,
              controller: _dayController,
              onInputChange: _removeErrorMessage,
            ),
            BirthdayTextField(
              index: 1,
              fieldName: 'Month',
              focusNode: _monthNode,
              controller: _monthController,
              onInputChange: _removeErrorMessage,
            ),
            BirthdayTextField(
              index: 2,
              fieldName: 'Year',
              focusNode: _yearNode,
              controller: _yearController,
              onInputChange: _removeErrorMessage,
            ),
          ],
        ),
        if (showErrorMessage == true) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Please fill in all fields to proceed.',
              style: AppTextStyles.onboarding16.copyWith(color: Colors.red),
            ),
          ),
        ],
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: IconButton(
              onPressed: () {
                if (_isInputValid()) {
                  _saveBirthday();
                  setState(() => showErrorMessage = false);
                  widget.onPressed();
                } else {
                  setState(() => showErrorMessage = true);
                }
              },
              style: IconButton.styleFrom(
                fixedSize: const Size(50, 50),
                backgroundColor: AppColors.white,
                shape: const CircleBorder(),
              ),
              icon: const Center(child: Icon(CupertinoIcons.arrow_right)),
            ),
          ),
        ),
        const SizedBox(height: 17),
      ],
    );
  }

  void _removeErrorMessage() {
    if (showErrorMessage == true) {
      setState(() => showErrorMessage = false);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class BirthdayTextField extends StatelessWidget {
  final int index;
  final String fieldName;
  final FocusNode focusNode;
  final TextEditingController controller;
  final VoidCallback onInputChange;

  const BirthdayTextField({
    super.key,
    required this.index,
    required this.fieldName,
    required this.focusNode,
    required this.controller,
    required this.onInputChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          SizedBox(
            height: 67,
            width: index < 2 ? 74 : 103,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              cursorColor: AppColors.grey95,
              style: AppTextStyles.textStyle25,
              keyboardType: TextInputType.number,
              decoration: AppInputDecoration.withCustomBorder(),
              onChanged: (value) {
                onInputChange();
                if (index < 2) {
                  if (value.length == 2) {
                    focusNode.nextFocus();
                  }
                } else {
                  if (value.length == 4) focusNode.unfocus();
                }
              },
              onTap: onInputChange,
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: Text(
              fieldName,
              style: AppTextStyles.onboarding16,
            ),
          ),
        ],
      ),
    );
  }
}
