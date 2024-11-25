import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/helpers/app_input_decoration_extension.dart';

class BirthdayDateInputFields extends StatelessWidget {
  final TextEditingController dayController;
  final TextEditingController monthController;
  final TextEditingController yearController;

  final FocusNode dayNode;
  final FocusNode monthNode;
  final FocusNode yearNode;

  final Function() removeErrorMessage;

  const BirthdayDateInputFields({
    super.key,
    required this.dayController,
    required this.monthController,
    required this.yearController,
    required this.dayNode,
    required this.monthNode,
    required this.yearNode,
    required this.removeErrorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BirthdayTextField(
          index: 0,
          fieldName: 'Date',
          focusNode: dayNode,
          controller: dayController,
          onInputChange: removeErrorMessage,
          nextFocusNode: monthNode,
        ),
        BirthdayTextField(
          index: 1,
          fieldName: 'Month',
          focusNode: monthNode,
          controller: monthController,
          onInputChange: removeErrorMessage,
          nextFocusNode: yearNode,
        ),
        BirthdayTextField(
          index: 2,
          fieldName: 'Year',
          focusNode: yearNode,
          controller: yearController,
          onInputChange: removeErrorMessage,
        ),
      ],
    );
  }
}

class BirthdayTextField extends StatelessWidget {
  final int index;
  final String fieldName;
  final FocusNode focusNode;
  final TextEditingController controller;
  final VoidCallback onInputChange;
  final FocusNode? nextFocusNode;

  const BirthdayTextField({
    super.key,
    required this.index,
    required this.fieldName,
    required this.focusNode,
    required this.controller,
    required this.onInputChange,
    this.nextFocusNode,
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(index == 2 ? 4 : 2),
                _InputRangeFormatter(index, focusNode),
              ],
              decoration: AppInputDecoration.withCustomBorder(),
              onChanged: (value) {
                onInputChange();

                // Handle deleting and moving to previous field
                if (value.isEmpty) {
                  if (index > 0) {
                    focusNode.previousFocus();
                  }
                } else if (value.length == (index == 2 ? 4 : 2)) {
                  // Move focus to next field if enough digits are entered
                  if (nextFocusNode != null) {
                    nextFocusNode!.requestFocus();
                  }
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

class _InputRangeFormatter extends TextInputFormatter {
  final int index;
  final FocusNode currentFocusNode;

  _InputRangeFormatter(this.index, this.currentFocusNode);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final input = int.tryParse(newValue.text);

    if (newValue.text.isEmpty) return newValue;

    switch (index) {
      case 0:
        if (input == null || input < 1 || input > 31) return oldValue;
        if (newValue.text.length == 1 && input > 3) currentFocusNode.nextFocus();
        break;
      case 1:
        if (input == null || input < 1 || input > 12) return oldValue;
        if (newValue.text.length == 1 && input > 1) currentFocusNode.nextFocus();
        break;
      case 2:
        if (newValue.text.length <= 4) {
          if (newValue.text.length < 4) return newValue;
          final currentYear = DateTime.now().year;
          if (input == null || input < 1900 || input > currentYear) return oldValue;
        }
        break;
    }
    return newValue;
  }
}
