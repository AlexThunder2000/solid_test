import 'package:flutter/material.dart';
import 'package:solid_test/utility/app_color_extension.dart';

class AppTheme {
  ThemeMode themeMode = ThemeMode.system;

  static final light =
      ThemeData.light().copyWith(extensions: [_lightAppColors]);

  static final _lightAppColors = AppColorsExtension(
    textMain: const Color(0xFFEDEDED),
    background: const Color(0xFFFFFFFF),
    accent: const Color(0xFF007ACC),
    accentHover: const Color(0xFF96D1F7),
    accentDisabled: const Color(0xFF77A6C4),
    active: const Color(0xFFD9D9D9),
  );

  static final dark = ThemeData.dark().copyWith(extensions: [_darkAppColors]);

  static final _darkAppColors = AppColorsExtension(
    textMain: const Color(0xFF161719),
    background: const Color(0xFF161719),
    accent: const Color(0xFFF4F46C),
    accentHover: const Color(0xFFFFFF00),
    accentDisabled: const Color(0xFF6E6F3A),
    active: const Color(0xFF2D2D26),
  );
}

extension AppThemeExtension on ThemeData {
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppTheme._lightAppColors;
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}
