part of 'message_cubit.dart';

class MessageState extends Equatable {
  final String messageText;
  final String? errorMessage;
  final bool isSuccess;


  const MessageState({
    this.messageText = "",
    this.errorMessage,
    this.isSuccess = false
});

MessageState copyWith({
  String? messageText,
  String? errorMessage,
  bool? isSuccess
}) {
  return MessageState(
    messageText: messageText?? this.messageText,
    errorMessage: errorMessage?? this.errorMessage,
    isSuccess: isSuccess?? this.isSuccess
  );
}

  @override
  List<Object?> get props => [
    messageText, errorMessage, isSuccess
  ];
}

final class MessageInitial extends MessageState {}
