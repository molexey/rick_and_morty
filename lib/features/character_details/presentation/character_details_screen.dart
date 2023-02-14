import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final int id;
  const CharacterDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Character ${id.toString()}'),
    );
  }
}
