import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character_details/repository/character_repository.dart';
import 'package:rick_and_morty/features/characteres/entity/character_entity.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final int id;
  const CharacterDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  final _characterRepository = CharacterResository();

  Future<CharacterEntity?> _getCharacter(int id) async {
    print('!!! 1 _getCharacter()');
    return await _characterRepository.getCharacter(id);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<CharacterEntity?>(
            future: _getCharacter(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final item = snapshot.data!;
                return Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: Image.network(
                              item.image,
                              width: 300,
                              height: 300,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(item.name, style: const TextStyle(fontSize: 20)),
                          Text('${item.status} — ${item.species}'),
                          Text('Last known location: ${item.location.name}'),
                          Text('Gender: ${item.gender}'),
                          Text('Number of episodes: ${item.episode.length}')
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: CupertinoActivityIndicator());
            }));
  }
}
