import 'package:demo_game_night/domain/entities/message.dart';

abstract class IMessageRepo {

  Future<void> addMessage(Message newMessage);

}