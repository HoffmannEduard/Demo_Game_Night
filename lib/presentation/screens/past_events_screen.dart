import 'package:demo_game_night/domain/entities/user.dart';
import 'package:flutter/material.dart';

class PastEventsScreen extends StatelessWidget {
  final User currentUser;
  const PastEventsScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bewerte Events'),
        ),
        body: Center(
          child: Text('Bewerte vergangene Events'),
        ),
    );
  }
}