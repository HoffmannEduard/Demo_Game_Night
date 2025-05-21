import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_game_night/domain/entities/game_vote.dart';

class GameVoteCubit extends Cubit<List<GameVote>> {
  GameVoteCubit() : super([]);

  void vote(GameVote vote) {
    // Prevent duplicate votes by the same user for the same suggestion
    if (!state.any((v) =>
        v.suggestionId == vote.suggestionId && v.userId == vote.userId)) {
      emit([...state, vote]);
    }
  }

  int countVotes(int suggestionId) {
    return state.where((v) => v.suggestionId == suggestionId).length;
  }
}