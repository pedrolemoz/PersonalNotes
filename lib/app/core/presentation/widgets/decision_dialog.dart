import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../utils/colors.dart';
import '../utils/typography.dart';
import 'app_button.dart';

class DecisionDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cancelText;
  final String confirmText;
  final void Function() onConfirm;

  const DecisionDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText = 'Cancelar',
  });

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async => true,
      child: AlertDialog(
        title: Text(title),
        titleTextStyle: AppTypography.textHeadline(),
        scrollable: false,
        contentPadding: const EdgeInsets.all(24),
        actionsPadding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  subtitle,
                  style: AppTypography.textSubtitle(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppButton(
                        color: AppColors.white,
                        borderColor: AppColors.black,
                        textColor: AppColors.black,
                        onTap: () => Modular.to.maybePop(),
                        text: cancelText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppButton(
                        color: AppColors.red,
                        borderColor: AppColors.darkRed,
                        textColor: AppColors.lightGray1,
                        text: confirmText,
                        onTap: onConfirm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
