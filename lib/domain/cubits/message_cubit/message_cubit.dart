import 'package:demo_game_night/domain/entities/message.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_message_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final IMessageRepo messageRepo;
  final IEventsRepo eventRepo;
  final User currentUser;

  MessageCubit({required this.messageRepo, required this.eventRepo, required this.currentUser}) : super(MessageInitial());

  void updateMessage(String message) {
    emit(state.copyWith(messageText: message));
  }

  Future<void> sendMessage(int eventId) async {
    if (state.messageText == '') {
      emit(state.copyWith(errorMessage: 'Du kannst keine leere Nachricht versenden'));
      return;
    }

    emit(state.copyWith(errorMessage: null));

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch, 
      eventId: eventId, 
      userId: currentUser.id, 
      messageDateTime: DateTime.now(), 
      messageText: state.messageText
      );
      
      await messageRepo.addMessage(newMessage);
      emit(state.copyWith(isSuccess: true));  
  }

  Future<void> loadMessages() async {
    final events = await eventRepo.getUpcomingEvents(currentUser);
    final messages = await messageRepo.loadMessagesForEventId(events);
    emit(state.copyWith(messages: messages));
  }

}
