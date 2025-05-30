class GameSuggestion {
  final int id;
  final int userId;
  final int eventId;
  final String suggestion;

  GameSuggestion({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.suggestion,
  });
}