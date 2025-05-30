import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_suggestion_cubit/game_suggestion_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_vote/game_vote_cubit.dart';
import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/game_suggestion.dart';
import 'package:demo_game_night/domain/entities/game_vote.dart';
import 'package:demo_game_night/presentation/widgets/create_game_suggestion.dart';
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
  void initState() {
    super.initState();
    // Load suggestions when the screen is first shown
    context.read<GameSuggestionCubit>().loadSuggestions(widget.event.id);
    // Load votes
    context.read<GameVoteCubit>().loadVotesForEvent(widget.event.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showSuggestionDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateGameSuggestion(controller: _controller, widget: widget),
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
                        final suggestionId = s.id; // Use real DB id!
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
                                onPressed: () async {
                                  final authState = context.read<AuthCubit>().state;
                                  int? userId;
                                  if (authState is AuthSuccess) {
                                    userId = authState.user.id;
                                  }
                                  if (userId != null) {
                                    final alreadyVoted = await context.read<GameVoteCubit>().hasUserVoted(suggestionId, userId);
                                    if (!alreadyVoted) {
                                      await context.read<GameVoteCubit>().vote(
                                        GameVote(
                                          suggestionId: suggestionId,
                                          eventId: widget.event.id,
                                          userId: userId,
                                        ),
                                      );
                                      await context.read<GameVoteCubit>().loadVotesForEvent(widget.event.id);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Du hast bereits abgestimmt!')),
                                      );
                                    }
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
        tooltip: 'Neuen Vorschlag hinzufügen',
        child: Icon(Icons.add),
      ),
    );
  }
}