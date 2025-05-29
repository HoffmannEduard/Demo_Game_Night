import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/message.dart';

abstract class IMessageRepo {

  Future<void> addMessage(Message newMessage);

  Future<List<Message>?> loadMessagesForEventId(List<GameNightEvent> events);

}