import 'package:demo_game_night/domain/entities/rating.dart';

abstract class IRatingRepo {

  Future<void> addRating(Rating rating);

  Future<List<Rating>?> getRatingsForEvent(int eventId);

  Future<Rating?> getRatingForEventAndUser(int userId, int eventId);
  
}