import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../core/models/note_model.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/datetime_extension.dart';
import '../../../core/utils/typography.dart';
import '../../../core/widgets/disable_splash.dart';

class NoteVisualizationPage extends StatelessWidget {
  final NoteModel noteModel;

  const NoteVisualizationPage({super.key, required this.noteModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          UniconsLine.pen,
          size: 28,
          color: AppColors.white,
        ),
      ),
      appBar: AppBar(
        title: Text(noteModel.title),
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: 'Voltar',
          splashRadius: 24,
          onPressed: () => Modular.to.maybePop(),
          icon: const Icon(
            UniconsLine.arrow_left,
            size: 28,
          ),
        ),
      ),
      body: DisableSplash(
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            Text(
              noteModel.content,
              style: AppTypography.textSubtitle(),
              textAlign: TextAlign.justify,
            ),
            const Divider(color: AppColors.gray, height: 24, thickness: 1),
            Text(
              '${noteModel.date.formattedDateTime} por ${noteModel.userModel.name}',
              style: AppTypography.textSubtitle(),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}