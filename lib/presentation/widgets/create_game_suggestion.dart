import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_suggestion_cubit/game_suggestion_cubit.dart';
import 'package:demo_game_night/domain/entities/game_suggestion.dart';
import 'package:demo_game_night/presentation/screens/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGameSuggestion extends StatelessWidget {
  const CreateGameSuggestion({
    super.key,
    required TextEditingController controller,
    required this.widget,
  }) : _controller = controller;

  final TextEditingController _controller;
  final EventDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Neuer Vorschlag'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Spielvorschlag',
          hintText: 'Name des Spiels',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
          child: Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: () {
            final suggestionText = _controller.text.trim();
            final authState = context.read<AuthCubit>().state;
            int? userId;
            if (authState is AuthSuccess) {
              userId = authState.user.id;
            }
            if (userId != null && suggestionText.isNotEmpty) {
              context.read<GameSuggestionCubit>().addSuggestion(
                GameSuggestion(
                  id: 0, // Provide a suitable id value or generate one as needed
                  userId: userId,
                  eventId: widget.event.id,
                  suggestion: suggestionText,
                ),
                widget.event.id,
              );
            }
            Navigator.of(context).pop();
            _controller.clear();
          },
        child: Text('Hinzufügen'),
      ),
      ],
    );
  }
}