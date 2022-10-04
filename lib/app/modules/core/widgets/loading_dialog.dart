import 'package:flutter/material.dart';

import '../utils/typography.dart';

class LoadingDialog extends StatelessWidget {
  final String text;

  const LoadingDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async => true,
      child: AlertDialog(
        content: Row(
          children: [
            const SizedBox(
              child: CircularProgressIndicator(strokeWidth: 3),
              height: 25,
              width: 25,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: AppTypography.textHeadline(),
            ),
          ],
        ),
      ),
    );
  }
}
