import 'package:demo_game_night/domain/entities/message.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_message_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final IMessageRepo messageRepo;
  final User currentUser;

  MessageCubit({required this.messageRepo, required this.currentUser}) : super(MessageInitial());

  void updateMessage(String message) {
    emit(state.copyWith(messageText: message));
  }

  Future<void> sendMessage(int eventId) async {
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch, 
      eventId: eventId, 
      userId: currentUser.id, 
      messageDateTime: DateTime.now(), 
      messageText: state.messageText
      );
      print(newMessage);
      messageRepo.addMessage(newMessage);
  }
}
