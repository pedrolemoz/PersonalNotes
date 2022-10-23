import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../core/models/note_model.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/datetime_extension.dart';
import '../../../core/utils/typography.dart';

class NoteCard extends StatelessWidget {
  final Function() onTap;
  final NoteModel noteModel;

  const NoteCard({super.key, required this.onTap, required this.noteModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      noteModel.title,
                      style: AppTypography.textHeadline(),
                      textAlign: TextAlign.justify,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      noteModel.content,
                      style: AppTypography.textSubtitle(),
                      textAlign: TextAlign.justify,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      noteModel.date.formattedDateTime,
                      style: AppTypography.textOverline(),
                      textAlign: TextAlign.justify,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
