import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:rick_and_morty/features/characteres/bloc/characters_bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characteres/presentation/characters_screen.dart';
import 'package:rick_and_morty/features/characteres/repository/characters_repository_remote.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(CharactersRepositoryRemote()).. add(const LoadCharacters()),
      child: const CharactersScreen(),
    );
  }
}