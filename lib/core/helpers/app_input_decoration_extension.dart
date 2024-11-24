import 'package:flutter/material.dart';

import '../app_colors.dart';

extension AppInputDecoration on InputDecoration {
  static InputDecoration withCustomBorder({
    BorderRadius? borderRadius,
    Color? borderColor,
    double? borderWidth,
  }) {
    InputBorder borderConfig() {
      return OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        borderSide: BorderSide(
          width: borderWidth ?? 1,
          color: borderColor ?? AppColors.grey95,
        ),
      );
    }

    return InputDecoration(
      filled: true,
      border: borderConfig(),
      enabledBorder: borderConfig(),
      focusedBorder: borderConfig(),
      fillColor: AppColors.black.withOpacity(0.25),
      contentPadding: EdgeInsets.only(top: 15, bottom: 18, left: 22, right: 22),
    );
  }
}
