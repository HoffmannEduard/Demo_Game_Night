import 'package:demo_game_night/domain/entities/game_suggestion.dart';
import 'package:demo_game_night/domain/entities/game_vote.dart';

abstract class IGameSuggestionRepo {
  Future<void> addSuggestion(GameSuggestion suggestion);

  Future<List<GameSuggestion>> getSuggestionsForEvent(int eventId);

  Future<void> addVote(GameVote vote);

  Future<List<GameVote>> getVotesForSuggestions(int suggestionId);

  Future<bool> hasUserVoted(int suggestionId, int userId);
}