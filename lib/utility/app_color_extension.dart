import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.textMain,
    required this.background,
    required this.accent,
    required this.accentHover,
    required this.accentDisabled,
    required this.active,
  });

  final Color textMain;
  final Color background;
  final Color accent;
  final Color accentHover;
  final Color accentDisabled;
  final Color active;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? textMain,
    Color? backgroundDark,
    Color? accent,
    Color? accentHover,
    Color? accentDisabled,
    Color? active,
  }) {
    return AppColorsExtension(
      textMain: textMain ?? this.textMain,
      background: backgroundDark ?? this.background,
      accent: accent ?? this.accent,
      accentHover: accentHover ?? this.accentHover,
      accentDisabled: accentDisabled ?? this.accentDisabled,
      active: active ?? this.active,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      textMain: Color.lerp(textMain, other.textMain, t)!,
      background: Color.lerp(background, other.background, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentHover: Color.lerp(accentHover, other.accentHover, t)!,
      accentDisabled: Color.lerp(accentDisabled, other.accentDisabled, t)!,
      active: Color.lerp(active, other.active, t)!,
    );
  }
}
