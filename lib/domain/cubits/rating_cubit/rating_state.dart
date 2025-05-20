part of 'rating_cubit.dart';

class RatingState extends Equatable {
  final double? hostRating;
  final double? foodRating;
  final double? eventRating;
  final String? errorMessage;
  final bool isSuccess;

  const RatingState({
    this.hostRating,
    this.foodRating,
    this.eventRating,
    this.errorMessage,
    this.isSuccess = false
  });

  RatingState copyWith({
    double? hostRating,
    double? foodRating,
    double? eventRating,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return RatingState(
      hostRating: hostRating ?? this.hostRating,
      foodRating: foodRating ?? this.foodRating,
      eventRating: eventRating ?? this.eventRating,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    hostRating,
    foodRating,
    eventRating,
    errorMessage,
    isSuccess
  ];
}

final class RatingInitial extends RatingState {}
