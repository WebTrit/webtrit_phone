import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppOutlinedButtonStyle {
  static final main = OutlinedButton.styleFrom(
    primary: AppColors.grey,
    onSurface: AppColors.grey,
    side: const BorderSide(
      color: AppColors.lightGrey,
    ),
  );

  static final primary = OutlinedButton.styleFrom(
    primary: AppColors.primary,
    onSurface: AppColors.primary,
    side: const BorderSide(
      color: AppColors.primary,
    ),
  );

  static final red = OutlinedButton.styleFrom(
    primary: AppColors.red,
    onSurface: AppColors.red,
    side: const BorderSide(
      color: AppColors.red,
    ),
  );

  static final mainThick = main.copyWith(
    minimumSize: MaterialStateProperty.all(const Size(64, 42)),
  );
}
