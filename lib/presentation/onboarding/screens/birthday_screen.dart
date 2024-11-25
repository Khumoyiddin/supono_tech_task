import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/network/shared_prefs.dart';
import '../widgets/birthday_text_field.dart';

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
        BirthdayDateInputFields(
          dayController: _dayController,
          monthController: _monthController,
          yearController: _yearController,
          dayNode: _dayNode,
          monthNode: _monthNode,
          yearNode: _yearNode,
          removeErrorMessage: _removeErrorMessage,
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

  Future<void> _saveBirthday() async {
    final prefs = SharedPreferencesHelper.instance;
    await prefs.setBirthdayDate(
      day: _dayController.text.trim(),
      month: _monthController.text.trim(),
      year: _yearController.text.trim(),
    );
  }

  bool _isInputValid() {
    return _dayController.text.isNotEmpty &&
        _monthController.text.isNotEmpty &&
        _yearController.text.isNotEmpty;
  }

  @override
  bool get wantKeepAlive => true;
}
