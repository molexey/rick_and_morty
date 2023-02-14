import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character_details/presentation/character_details_screen.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';
import 'package:rick_and_morty/features/characteres/repository/characters_repository.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _charactersRepository = CharactersRepository();

  final _items = ValueNotifier<List<CharacterEntity>?>(null);

  Future<void> _getCharacters(bool refresh) async {
    print('!!! 1 _getCharacters()');
    final result = await _charactersRepository.getCharacters(refresh);
    if (result != null) _items.value = List.of(result);
  }

  @override
  void initState() {
    _getCharacters(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: ValueListenableBuilder<List<CharacterEntity>?>(
        valueListenable: _items,
        builder: (context, items, child) {
          if (items != null) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final triggerIndex = max(0, items.length - 5);
                final hasMorePage = CharactersRepository.hasMorePage;

                final item = items[index];
                print('currentIndex $index');
                print(
                    'triggerIndex $triggerIndex, items.length ${items.length}');
                print(
                    ' hasMorePage && index == triggerIndex ${hasMorePage && index == triggerIndex}');
                if (hasMorePage && index == triggerIndex) _getCharacters(false);

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
                      builder: (context) => CharacterDetailsScreen(id: item.id),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: items.length,
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
