import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextButtonStyle {
  static final main = TextButton.styleFrom(
    primary: AppColors.primary,
    onSurface: AppColors.primary,
  );

  static final text = TextButton.styleFrom(
    primary: AppColors.grey,
    onSurface: AppColors.grey,
  );

  static final primary = TextButton.styleFrom(
    primary: AppColors.white,
    onSurface: AppColors.white,
    backgroundColor: AppColors.primary,
  );

  static final white = TextButton.styleFrom(
    primary: AppColors.black,
    onSurface: AppColors.black,
    backgroundColor: AppColors.white,
  );

  static final red = TextButton.styleFrom(
    primary: AppColors.white,
    onSurface: AppColors.white,
    backgroundColor: AppColors.red,
  );

  static final primaryThick = primary.copyWith(
    minimumSize: MaterialStateProperty.all(const Size(64, 42)),
  );

  static final whiteThick = white.copyWith(
    minimumSize: MaterialStateProperty.all(const Size(64, 42)),
  );
}
