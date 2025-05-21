part of 'rating_cubit.dart';

class RatingState extends Equatable {
  final double? hostRating;
  final double? foodRating;
  final double? eventRating;
  final String? errorMessage;
  final bool userRatedForEvent;

  final double? avgHost;
  final double? avgFood;
  final double? avgEvent;

  const RatingState({
    this.hostRating,
    this.foodRating,
    this.eventRating,
    this.errorMessage,
    this.userRatedForEvent = false,

    this.avgHost,
    this.avgFood,
    this.avgEvent
  });

  RatingState copyWith({
    double? hostRating,
    double? foodRating,
    double? eventRating,
    String? errorMessage,
    bool? userRatedForEvent,

    double? avgHost,
    double? avgFood,
    double? avgEvent
  }) {
    return RatingState(
      hostRating: hostRating ?? this.hostRating,
      foodRating: foodRating ?? this.foodRating,
      eventRating: eventRating ?? this.eventRating,
      errorMessage: errorMessage ?? this.errorMessage,
      userRatedForEvent: userRatedForEvent ?? this.userRatedForEvent,

      avgHost: avgHost ?? this.avgHost,
      avgFood: avgFood ?? this.avgFood,
      avgEvent: avgEvent ?? this.avgEvent
    );
  }

  @override
  List<Object?> get props => [
    hostRating,
    foodRating,
    eventRating,
    errorMessage,
    userRatedForEvent,
    avgEvent,
    avgFood,
    avgHost
  ];
}

final class RatingInitial extends RatingState {}
