import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/datetime_extension.dart';
import '../../../core/utils/typography.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;

  const NoteCard({
    super.key,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightGray2,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.gray),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.textHeadline(),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    content,
                    style: AppTypography.textSubtitle(),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    date.formattedDateTime,
                    style: AppTypography.textOverline(),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const VerticalDivider(),
            const Icon(
              UniconsLine.angle_right,
              size: 30,
              color: AppColors.darkGray3,
            )
          ],
        ),
      ),
    );
  }
}
