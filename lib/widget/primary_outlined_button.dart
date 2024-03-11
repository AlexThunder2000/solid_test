import 'package:flutter/material.dart';
import 'package:solid_test/utility/app_theme.dart';
import 'package:solid_test/utility/text_style_source.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool isEnabled;

  const PrimaryOutlinedButton({
    required this.title,
    required this.onPressed,
    this.isEnabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return BorderSide(color: context.theme.appColors.accentHover);
            }
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(color: context.theme.appColors.accentDisabled);
            }
            return BorderSide(color: context.theme.appColors.accent);
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return context.theme.appColors.accentHover;
            }
            if (states.contains(MaterialState.disabled)) {
              return context.theme.appColors.accentDisabled;
            }
            return context.theme.appColors.accent;
          },
        ),
      ),
      onPressed: isEnabled ? () => onPressed() : null,
      child: Text(title, style: TextStyleSource.lato14rg140),
    );
  }
}
