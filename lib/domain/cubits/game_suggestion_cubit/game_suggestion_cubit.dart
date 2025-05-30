import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_game_night/domain/entities/game_suggestion.dart';
import 'package:demo_game_night/domain/i_repos/i_game_suggestion_repo.dart';

class GameSuggestionCubit extends Cubit<List<GameSuggestion>> {
  final IGameSuggestionRepo repo;

  GameSuggestionCubit(this.repo) : super([]);

  Future<void> loadSuggestions(int eventId) async {
    final suggestions = await repo.getSuggestionsForEvent(eventId);
    emit(suggestions);
  }

  Future<void> addSuggestion(GameSuggestion suggestion, int eventId) async {
    await repo.addSuggestion(suggestion);
    await loadSuggestions(eventId);
  }
}