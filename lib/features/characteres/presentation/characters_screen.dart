import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_details/bloc/character_details_bloc/character_details_bloc.dart';
import 'package:rick_and_morty/features/character_details/presentation/character_details_screen.dart';
import 'package:rick_and_morty/features/characteres/bloc/characters_bloc/characters_bloc.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            final bloc = context.read<CharactersBloc>();
            switch (state.status) {
              case StatsStatus.success:
                final items = state.items;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final triggerIndex = max(0, items.length - 5);
                    final hasMorePage = state.isHasMorePage;

                    final item = items[index];
                    print('currentIndex $index');
                    print(
                        'triggerIndex $triggerIndex, items.length ${items.length}');
                    print(
                        ' hasMorePage && index == triggerIndex ${hasMorePage && index == triggerIndex}');
                    if (hasMorePage && index == triggerIndex) {
                      bloc.add(const LoadCharacters(refresh: false));
                    }

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: Image.network(item.image),
                      ),
                      title: Text(item.name),
                      subtitle: Text('${item.gender}, ${item.species}'),
                      trailing: const Icon(Icons.navigate_next),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => CharacterDetailsBloc(),
                            child: CharacterDetailsScreen(id: item.id),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: items.length,
                );
              case StatsStatus.failure:
                return Center(
                  child: Column(
                    children: [
                      const Text('Ошибка загрузки данных,\nповторите попытку'),
                      ElevatedButton(
                        onPressed: () => bloc.add(const LoadCharacters()),
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                );

              case StatsStatus.initial:
              case StatsStatus.loading:
                return const Center(child: CupertinoActivityIndicator());
            }
          }),
    );
  }
}
