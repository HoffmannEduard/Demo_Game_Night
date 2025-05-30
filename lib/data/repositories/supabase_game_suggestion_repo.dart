import 'package:demo_game_night/domain/i_repos/i_game_suggestion_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:demo_game_night/domain/entities/game_suggestion.dart';
import 'package:demo_game_night/domain/entities/game_vote.dart';

class SupabaseGameSuggestionRepo implements IGameSuggestionRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<int> addSuggestion(GameSuggestion suggestion) async {
    final res = await supabase.from('gamesuggestion').insert({
      'event_id': suggestion.eventId,
      'user_id': suggestion.userId,
      'suggestion': suggestion.suggestion,
    }).select('id').single();
    return res['id'] as int;
  }

  @override
  Future<List<GameSuggestion>> getSuggestionsForEvent(int eventId) async {
    final res = await supabase
        .from('gamesuggestion')
        .select('id, event_id, user_id, suggestion')
        .eq('event_id', eventId);

    return (res as List).map((s) => GameSuggestion(
      id: s['id'],
      userId: s['user_id'],
      eventId: s['event_id'],
      suggestion: s['suggestion'],
    )).toList();
  }

  @override
  Future<void> addVote(GameVote vote) async {
    await supabase.from('gamevote').insert({
      'suggestion_id': vote.suggestionId,
      'user_id': vote.userId,
    });
  }

  @override
  Future<List<GameVote>> getVotesForSuggestions(int suggestionId) async {
    final res = await supabase
        .from('gamevote')
        .select('suggestion_id, user_id')
        .eq('suggestion_id', suggestionId);
    return (res as List).map((v) => GameVote(
      suggestionId: v['suggestion_id'],
      eventId: 0,
      userId: v['user_id'],
    )).toList();
  }

  @override
  Future<bool> hasUserVoted(int suggestionId, int userId) async {
    final res = await supabase
        .from('gamevote')
        .select('id')
        .eq('suggestion_id', suggestionId)
        .eq('user_id', userId)
        .maybeSingle();
    return res != null;
  }
}