import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/presentation/widgets/logout_button.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  final User currentUser;
  const NewsScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          LogoutButton()
        ],
        ),
        body: Center(
          child: Text('Hier stehen bald News'),
        ),
    );
  }
}