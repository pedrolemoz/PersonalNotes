import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/disable_splash.dart';
import '../../../core/widgets/unfocus_widget.dart';

class NoteCreationPage extends StatelessWidget {
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar nota'),
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
      body: UnfocusWidget(
        child: DisableSplash(
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: [
              AppTextField(
                controller: titleTextController,
                hintText: 'Título',
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: contentTextController,
                hintText: 'Escreva sua nota aqui',
                maxLines: 20,
              ),
              const SizedBox(height: 16),
              AppButton(
                onTap: () {},
                text: 'Criar nova nota',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
