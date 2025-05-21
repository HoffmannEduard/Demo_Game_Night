class Rating {
  int id;
  int eventId;
  int userId;
  double? ratingHost;
  double? ratingFood;
  double? ratingEvent;

  Rating({
    required this.id,
    required this.eventId,
    required this.userId,
    this.ratingHost,
    this.ratingFood,
    this.ratingEvent
  });

  Rating copyWith({
    int? id,
    int? eventId,
    int? userId,
    double? ratingHost,
    double? ratingFood,
    double? ratingEvent,
  }) {
    return Rating(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      ratingHost: ratingHost ?? this.ratingHost,
      ratingFood: ratingFood ?? this.ratingFood,
      ratingEvent: ratingEvent ?? this.ratingEvent,
    );
  }

  @override
  String toString() {
    return 'User: $userId und Event: $eventId: Das erstellte Event hat folgende Bewertung: Gastgeber: $ratingHost, Essen: $ratingFood, Abend gesamt: $ratingEvent';
  }

}