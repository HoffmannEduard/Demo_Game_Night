import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/presentation/widgets/logout_button.dart';
import 'package:demo_game_night/presentation/widgets/past_event_view.dart';
import 'package:flutter/material.dart';

class PastEventsScreen extends StatelessWidget {
  final User currentUser;
  const PastEventsScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vergangene Events'),
          actions: [
          LogoutButton()
        ],
        ),
        body: PastEventView(),
      );
  }
}