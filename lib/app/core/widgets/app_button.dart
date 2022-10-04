import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/typography.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.all<Color>(color ?? AppColors.blue),
        overlayColor: MaterialStateProperty.all<Color>(borderColor ?? AppColors.blueBorder),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor ?? AppColors.blueBorder),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          text,
          style: AppTypography.button(color: textColor),
        ),
      ),
    );
  }
}
