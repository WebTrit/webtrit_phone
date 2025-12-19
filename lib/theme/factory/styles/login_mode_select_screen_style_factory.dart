import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';
import 'theme_image_style.dart';
// Імпорт вашої нової фабрики для стилів зображень

class LoginModeSelectScreenStyleFactory implements ThemeStyleFactory<LoginModeSelectScreenStyles> {
  LoginModeSelectScreenStyleFactory(this.config, this.colors);

  final LoginModeSelectPageConfig? config;
  final ColorScheme colors;

  @override
  LoginModeSelectScreenStyles create() {
    // 1. Делегуємо створення стилю картинки окремій фабриці.
    // Вона сама розпарсить URI, scale та padding з config?.mainLogo (ImageSource).
    final pictureLogoStyle = ThemeImageStyleFactory(
      source: config?.mainLogo,
    ).create();

    final textStyle = TextStyle(color: colors.onPrimary, fontWeight: FontWeight.w600);
    return LoginModeSelectScreenStyles(
      primary: LoginModeSelectScreenStyle(
        systemUiOverlayStyle: config?.systemUiOverlayStyle?.toSystemUiOverlayStyle(),

        // 2. Передаємо готовий ThemeImageStyle у нове поле
        pictureLogoStyle: pictureLogoStyle,
        onboardingTextStyle: textStyle, // <--- Передаємо стиль сюди

        signInTypeButton: config?.buttonSignupStyleType,
        signUpTypeButton: config?.buttonLoginStyleType,
      ),
    );
  }
}