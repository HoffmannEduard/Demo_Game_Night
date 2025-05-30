import 'package:demo_game_night/domain/entities/rating.dart';
import 'package:demo_game_night/domain/i_repos/i_rating_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRatingRepo implements IRatingRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addRating(Rating rating) async {
    try {
    await supabase.from('rating').insert({
      'id': rating.id,
      'event_id': rating.eventId,
      'user_id': rating.userId,
      'ratinghost': rating.ratingHost,
      'ratingfood': rating.ratingFood,
      'ratingevent': rating.ratingEvent,
    });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Rating>?> getRatingsForEvent(int eventId) async {
    final res = await supabase
        .from('rating')
        .select('id, event_id, user_id, ratinghost, ratingfood, ratingevent')
        .eq('event_id', eventId);

    if (res.isEmpty) return null;
    return (res as List).map((r) => Rating(
      id: r['id'],
      eventId: r['event_id'],
      userId: r['user_id'],
      ratingHost: (r['ratinghost'] as num?)?.toDouble(),
      ratingFood: (r['ratingfood'] as num?)?.toDouble(),
      ratingEvent: (r['ratingevent'] as num?)?.toDouble(),
    )).toList();
  }

  @override
  Future<Rating?> getRatingForEventAndUser(int userId, int eventId) async {
    final res = await supabase
        .from('rating')
        .select('id, event_id, user_id, ratinghost, ratingfood, ratingevent')
        .eq('user_id', userId)
        .eq('event_id', eventId)
        .maybeSingle();

    if (res == null) return null;

    return Rating(
      id: res['id'],
      eventId: res['event_id'],
      userId: res['user_id'],
      ratingHost: (res['ratinghost'] as num?)?.toDouble(),
      ratingFood: (res['ratingfood'] as num?)?.toDouble(),
      ratingEvent: (res['ratingevent'] as num?)?.toDouble(),
    );
  }
}
