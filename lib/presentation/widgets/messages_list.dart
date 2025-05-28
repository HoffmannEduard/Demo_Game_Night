import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_game_night/domain/cubits/message_cubit/message_cubit.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        final messages = state.messages.reversed.toList();

        if (messages.isEmpty) {
          return const Center(child: Text('Keine Nachrichten vorhanden.'));
        }

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];
            return Card(
              margin: EdgeInsets.all(2),
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              child: ListTile(
                title: Text(msg.messageText),
                subtitle: Text('User #${msg.userId} am ${msg.messageDateTime}'),
              ),
            );
          },
        );
      },
    );
  }
}
