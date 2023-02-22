import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character_details/bloc/character_details_bloc/character_details_bloc.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final int id;
  const CharacterDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  void initState() {
    context.read<CharacterDetailsBloc>().add(LoadCharacter(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case CharacterStatus.success:
                final item = state.item!;
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

              case CharacterStatus.loading:
                return const Center(child: CupertinoActivityIndicator());

              case CharacterStatus.failure:
                return Center(
                  child: Column(
                    children: [
                      const Text('Ошибка загрузки данных,\nповторите попытку'),
                      ElevatedButton(
                        onPressed: () => context
                            .read<CharacterDetailsBloc>()
                            .add(LoadCharacter(widget.id)),
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                );
            }
          }),
    );
  }
}
