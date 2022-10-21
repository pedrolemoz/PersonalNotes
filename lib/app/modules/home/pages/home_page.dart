import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../core/controllers/root/root_bloc.dart';
import '../../../core/utils/colors.dart';
import '../widgets/note_card.dart';

class HomePage extends StatelessWidget {
  final rootBloc = Modular.get<RootBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          UniconsLine.plus,
          size: 28,
          color: AppColors.white,
        ),
        onPressed: () {},
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
      body: ListView.separated(
        padding: const EdgeInsets.all(32),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => NoteCard(
          title: 'Nota ${index + 1}',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed gravida tortor id blandit rhoncus...',
          date: DateTime.now(),
        ),
      ),
    );
  }
}
