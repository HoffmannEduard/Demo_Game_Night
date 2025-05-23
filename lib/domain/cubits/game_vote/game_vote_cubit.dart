import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_game_night/domain/entities/game_vote.dart';
import 'package:demo_game_night/domain/i_repos/i_game_suggestion_repo.dart';

class GameVoteCubit extends Cubit<List<GameVote>> {
  final IGameSuggestionRepo repo;

  GameVoteCubit(this.repo) : super([]);

  Future<void> vote(GameVote vote) async {
    final alreadyVoted = await repo.hasUserVoted(vote.suggestionId, vote.userId);
    if (!alreadyVoted) {
      await repo.addVote(vote);
    }
  }

  Future<void> loadVotesForEvent(int eventId) async {
    final suggestions = await repo.getSuggestionsForEvent(eventId);
    final suggestionIds = suggestions.map((s) => s.id).toList();

    List<GameVote> allVotes = [];
    for (final id in suggestionIds) {
      final votes = await repo.getVotesForSuggestions(id);
      allVotes.addAll(votes);
    }
    emit(allVotes);
  }

  Future<bool> hasUserVoted(int suggestionId, int userId) async {
    return await repo.hasUserVoted(suggestionId, userId);
  }
}