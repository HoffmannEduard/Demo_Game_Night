import 'package:demo_game_night/data/mock_data.dart';
import 'package:demo_game_night/domain/entities/message.dart';
import 'package:demo_game_night/domain/i_repos/i_message_repo.dart';

class FakeMessageRepo implements IMessageRepo {

  @override
  Future<void> addMessage(Message newMessage) async {
    MockData.mockMessage.add(newMessage);
  }

}