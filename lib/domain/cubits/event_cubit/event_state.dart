part of 'event_cubit.dart';

sealed class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

final class UpcomingEventLoaded extends EventState {
  final List<GameNightEvent> upcomingEvents;
  const UpcomingEventLoaded(this.upcomingEvents);
}

final class PastEventLoaded extends EventState {
  final List<GameNightEvent> pastEvents;
  const PastEventLoaded(this.pastEvents);
}

final class EventError extends EventState {
  final String message;
  const EventError(this.message);
}