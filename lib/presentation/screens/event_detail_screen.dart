import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_suggestion_cubit/game_suggestion_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_vote/game_vote_cubit.dart';
import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/game_suggestion.dart';
import 'package:demo_game_night/domain/entities/game_vote.dart';
import 'package:demo_game_night/presentation/widgets/host_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailScreen extends StatefulWidget {
  final GameNightEvent event;
  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showSuggestionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                    userId: userId,
                    eventId: widget.event.id,
                    suggestion: suggestionText,
                  ),
                );
              }
              Navigator.of(context).pop();
              _controller.clear();
            },
          child: Text('Hinzufügen'),
        ),
        ],
      ),
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
      ),
      body: Column(
        children: [
          Center(child: HostDetails(event: widget.event)),
          SizedBox(height: 8.0),
          Container(
            color: Colors.amberAccent,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Spielevorschläge',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Expanded(
            child: BlocBuilder<GameSuggestionCubit, List<GameSuggestion>>(
              builder: (context, suggestions) {
                final eventSuggestions = suggestions
                    .where((s) => s.eventId == widget.event.id)
                    .toList();
                if (eventSuggestions.isEmpty) {
                  return Text('Hier stehen die Vorschläge');
                }
                return BlocBuilder<GameVoteCubit, List<GameVote>>(
                  builder: (context, votes) {
                    return ListView(
                      children: eventSuggestions.map((s) {
                        // Use the index in the global suggestions list as suggestionId
                        final suggestionId = context.read<GameSuggestionCubit>().state.indexOf(s);
                        final voteCount = votes.where((v) => v.suggestionId == suggestionId).length;
                        return ListTile(
                          title: Text(s.suggestion),
                          subtitle: Text('User ID: ${s.userId}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('$voteCount'),
                              IconButton(
                                icon: Icon(Icons.thumb_up),
                                tooltip: 'Abstimmen',
                                onPressed: () {
                                  final authState = context.read<AuthCubit>().state;
                                  int? userId;
                                  if (authState is AuthSuccess) {
                                    userId = authState.user.id;
                                  }
                                  if (userId != null) {
                                    context.read<GameVoteCubit>().vote(
                                      GameVote(
                                        suggestionId: suggestionId,
                                        eventId: widget.event.id,
                                        userId: userId,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSuggestionDialog,
        child: Icon(Icons.add),
        tooltip: 'Spiel vorschlagen',
      ),
    );
  }
}