part of 'message_cubit.dart';

class MessageState extends Equatable {
  final String messageText;
  final String? errorMessage;
  final bool isSuccess;
  final List<Message> messages;


  const MessageState({
    this.messageText = "",
    this.errorMessage,
    this.isSuccess = false,
    this.messages = const []
});

MessageState copyWith({
  String? messageText,
  String? errorMessage,
  bool? isSuccess,
  List<Message>? messages,
}) {
  return MessageState(
    messageText: messageText?? this.messageText,
    errorMessage: errorMessage?? this.errorMessage,
    isSuccess: isSuccess?? this.isSuccess,
    messages: messages?? this.messages
  );
}

  @override
  List<Object?> get props => [
    messageText, errorMessage, isSuccess, messages
  ];
}

final class MessageInitial extends MessageState {}
