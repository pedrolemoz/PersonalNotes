import 'package:flutter/material.dart';

import '../utils/typography.dart';
import 'app_button.dart';

class WarningMessage extends StatelessWidget {
  final String message;
  final bool enableRetry;
  final void Function()? onRetry;

  const WarningMessage({
    super.key,
    required this.message,
    this.enableRetry = false,
    this.onRetry,
  }) : assert(
          enableRetry ? onRetry != null : true,
          'onRetry should be specified if enableRetry is true',
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: AppTypography.textHeadline(),
              textAlign: TextAlign.center,
            ),
            if (enableRetry) ...[
              const SizedBox(height: 32),
              AppButton(onTap: onRetry!, text: 'Tentar novamente'),
            ]
          ],
        ),
      ),
    );
  }
}
