import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/presentation/widgets/logout_button.dart';
import 'package:demo_game_night/presentation/widgets/upcoming_event_view.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final User currentUser;
  const EventScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bevorstehende Events'),
          actions: [
          LogoutButton()
        ],
        ),
        body: UpcomingEventView(),
      );
  }
}