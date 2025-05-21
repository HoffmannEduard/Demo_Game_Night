import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_game_night/domain/entities/game_suggestion.dart';

class GameSuggestionCubit extends Cubit<List<GameSuggestion>> {
  GameSuggestionCubit() : super([]);

  void addSuggestion(GameSuggestion suggestion) {
    emit([...state, suggestion]);
  }

  List<GameSuggestion> suggestionsForEvent(int eventId) {
    return state.where((s) => s.eventId == eventId).toList();
  }
}