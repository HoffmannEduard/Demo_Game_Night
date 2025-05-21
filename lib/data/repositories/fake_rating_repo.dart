import 'package:demo_game_night/data/mock_data.dart';
import 'package:demo_game_night/domain/entities/rating.dart';
import 'package:demo_game_night/domain/i_repos/i_rating_repo.dart';

class FakeRatingRepo implements IRatingRepo {

@override
Future<void> addRating(Rating newRating) async {
    MockData.mockRatings.add(newRating);
  }

@override
Future<List<Rating>?> getRatingsForEvent(int eventId) async {
  return MockData.mockRatings
    .where((rating) => rating.eventId == eventId)
    .toList();
}

@override
Future<Rating?> getRatingForEventAndUser(int userId, int eventId) async {
  try {
  return MockData.mockRatings
  .firstWhere((rating) => rating.userId == userId && rating.eventId == eventId);
  } catch (_) {
    return null;
  }
}

}