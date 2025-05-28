class Message {
  final int id;
  final int eventId;
  final int userId;
  final DateTime messageDateTime;
  final String messageText;

  Message({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.messageDateTime,
    required this.messageText
  });

  @override
  String toString() {
    return 'EventID: $eventId \nUserId: $userId \nText: $messageText';
  }
}