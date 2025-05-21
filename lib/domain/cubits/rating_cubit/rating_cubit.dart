
import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/rating.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_rating_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  final User currentUser;
  final GameNightEvent currentEvent;
  final IRatingRepo ratingRepo;
  
  RatingCubit({required this.currentUser, required this.currentEvent, required this.ratingRepo}) : super(RatingState());
//TODO Error abfangen
  void updateHostRating(double hostRating) {
    emit(state.copyWith(hostRating: hostRating));
  }

  void updateFoodRating(double foodRating) {
    emit(state.copyWith(foodRating: foodRating));
  }

  void updateEventRating(double eventRating) {
    emit(state.copyWith(eventRating: eventRating));
  }

  Future<void> loadAverageRatings() async {
  final ratings = await ratingRepo.getRatingsForEvent(currentEvent.id);
  if (ratings == null || ratings.isEmpty) {
    emit(state.copyWith(avgHost: 0.0, avgFood: 0.0, avgEvent: 0.0));
    return;
  }

  double sumHost = 0;
  double sumFood = 0;
  double sumEvent = 0;
  int count = ratings.length;

  for (var r in ratings) {
    sumHost += r.ratingHost ?? 0;
    sumFood += r.ratingFood ?? 0;
    sumEvent += r.ratingEvent ?? 0;
  }

  emit(state.copyWith(
    avgHost: sumHost / count,
    avgFood: sumFood / count,
    avgEvent: sumEvent / count,
  ));
}

  Future<void> checkIfUserRatedForEvent() async {
    final userRating = await ratingRepo.getRatingForEventAndUser(currentUser.id, currentEvent.id);
    if (userRating != null) {
      emit(state.copyWith(
        hostRating: userRating.ratingHost,
        eventRating: userRating.ratingEvent,
        foodRating: userRating.ratingFood,
        userRatedForEvent: true
        ));
    }

  }

  Future<void> addRating() async {
    //TODO Validierung implementieren
    final newRating = Rating(
      id: DateTime.now().millisecondsSinceEpoch, 
      eventId: currentEvent.id, 
      userId: currentUser.id,
      ratingHost: state.hostRating,
      ratingFood: state.foodRating,
      ratingEvent: state.eventRating
      );
    await ratingRepo.addRating(newRating);
    await loadAverageRatings();
    emit(state.copyWith(userRatedForEvent: true));
  }

}
