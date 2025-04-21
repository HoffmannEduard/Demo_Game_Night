import 'package:demo_game_night/domain/entities/user.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final User currentUser;
  const EventScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bevorstehende Events'),
        ),
        body: Center(
          child: Text('Hier stehen bald die nächsten Events'),
        ),
    );
  }
}