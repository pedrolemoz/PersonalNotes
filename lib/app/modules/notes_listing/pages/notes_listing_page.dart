import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../core/models/note_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/utils/colors.dart';
import '../../../core/widgets/disable_splash.dart';
import '../widgets/note_card.dart';

class NotesListingPage extends StatelessWidget {
  final mockedNotes = List.generate(
    65,
    (index) => NoteModel(
      userModel: const UserModel(email: 'aaa', name: 'Pedro Lemos'),
      title: 'Nota ${index + 1}',
      content:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras a pharetra nulla, ac gravida purus. In a tincidunt nibh, ac pharetra enim. Donec eget fringilla nisl. Nam nec fringilla metus. Quisque vel tortor tincidunt, fermentum orci in, luctus ex. Vivamus quis felis sed turpis commodo tristique. Fusce tempus mauris eget porta volutpat. In eleifend, ligula eu rutrum mattis, dolor odio ultricies tellus, sit amet elementum nisi nisl a sem. Praesent quis lorem vitae tellus commodo aliquam vel et erat. Maecenas dapibus elit libero, eu efficitur ipsum facilisis sit amet. Vestibulum ac metus metus. Vestibulum viverra lacinia molestie. Donec venenatis a augue non pulvinar.

Aliquam erat volutpat. Etiam a ultricies tellus. Fusce vitae lectus ut urna mollis luctus non nec erat. Etiam fermentum risus felis, eget maximus elit dictum et. Morbi fermentum arcu in mauris dictum, at sollicitudin elit malesuada. Vestibulum eget risus ultrices, tristique nibh non, ultrices mi. Vivamus scelerisque turpis nibh, vitae ultrices arcu aliquet et.''',
      date: DateTime.now(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          UniconsLine.plus,
          size: 28,
          color: AppColors.white,
        ),
        onPressed: () => Modular.to.pushNamed('/note_creation/'),
      ),
      appBar: AppBar(
        title: const Text('Suas Notas'),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              tooltip: 'Abrir menu',
              splashRadius: 24,
              onPressed: () => Modular.to.maybePop(),
              icon: const Icon(
                UniconsLine.bars,
                size: 28,
              ),
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                tooltip: 'Buscar',
                splashRadius: 24,
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                icon: const Icon(UniconsLine.search),
              );
            },
          )
        ],
      ),
      body: DisableSplash(
        child: ListView.separated(
          padding: const EdgeInsets.all(32),
          itemCount: mockedNotes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final note = mockedNotes[index];
            return NoteCard(
              onTap: () => Modular.to.pushNamed('/note_visualization/', arguments: note),
              noteModel: note,
            );
          },
        ),
      ),
    );
  }
}
