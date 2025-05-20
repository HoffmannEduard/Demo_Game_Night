
import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/rating.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  final User currentUser;
  final GameNightEvent currentEvent;
  
  RatingCubit({required this.currentUser, required this.currentEvent}) : super(RatingInitial());

  void updateHostRating(double hostRating) {
    emit(state.copyWith(hostRating: hostRating));
  }

  void updateFoodRating(double foodRating) {
    emit(state.copyWith(foodRating: foodRating));
  }

  void updateEventRating(double eventRating) {
    emit(state.copyWith(eventRating: eventRating));
  }



  bool addRating() {

    final newRating = Rating(
      id: DateTime.now().millisecondsSinceEpoch, 
      eventId: currentEvent.id, 
      userId: currentUser.id,
      ratingHost: state.hostRating,
      ratingFood: state.foodRating,
      ratingEvent: state.eventRating
      );
    print(newRating);

    return true;
  }

}
