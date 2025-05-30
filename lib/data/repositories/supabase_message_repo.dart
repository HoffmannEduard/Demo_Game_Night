import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/message.dart';
import 'package:demo_game_night/domain/i_repos/i_message_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMessageRepo implements IMessageRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addMessage(Message newMessage) async {
    try {
      await supabase.from('message').insert({
        'id': newMessage.id,
        'event_id': newMessage.eventId,
        'eventname': newMessage.eventName,
        'user_id': newMessage.userId,
        'username': newMessage.username,
        'timestamp': newMessage.messageDateTime.toIso8601String(),
        'message': newMessage.messageText,
      });
    } catch (e) {
      print('Error adding message: $e');
    }
  }

  @override
  Future<List<Message>?> loadMessagesForEventId(List<GameNightEvent> events) async {
    if (events.isEmpty) return [];

    final eventIds = events.map((e) => e.id).toList();

    try {
      final res = await supabase
          .from('message')
          .select(
              'id, event_id, eventname, user_id, username, timestamp, message')
          .inFilter('event_id', eventIds)
          .order('timestamp', ascending: true);

      if (res.isEmpty) return [];

      return (res as List).map((m) => Message(
        id: m['id'],
        eventId: m['event_id'],
        eventName: m['eventname'] ?? '',
        userId: m['user_id'],
        username: m['username'] ?? '',
        messageDateTime: DateTime.parse(m['timestamp']),
        messageText: m['message'] ?? '',
      )).toList();
    } catch (e) {
      print('Error loading messages: $e');
      return [];
    }
  }
}
