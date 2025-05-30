class Message {
  final int id;
  final int eventId;
  final String eventName;
  final int userId;
  final String username;
  final DateTime messageDateTime;
  final String messageText;

  Message({
    required this.id,
    required this.eventId,
    required this.eventName,
    required this.userId,
    required this.username,
    required this.messageDateTime,
    required this.messageText
  });

  @override
  String toString() {
    return 'EventID: $eventId \nUserId: $userId \nText: $messageText';
  }
}