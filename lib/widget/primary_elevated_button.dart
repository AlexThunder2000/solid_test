import 'package:flutter/material.dart';
import 'package:solid_test/utility/app_theme.dart';
import 'package:solid_test/utility/text_style_source.dart';

class PrimaryElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isEnabled;

  const PrimaryElevatedButton({
    required this.title,
    required this.onPressed,
    this.isEnabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
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
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
      onPressed: isEnabled ? () => onPressed() : null,
      child: Text(
        title,
        style: TextStyleSource.lato14rg140
            .copyWith(color: context.theme.appColors.textMain),
      ),
    );
  }
}
