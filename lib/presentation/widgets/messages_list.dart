import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_game_night/domain/cubits/message_cubit/message_cubit.dart';
import 'package:intl/intl.dart';

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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(msg.username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    Text(msg.eventName)
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      color: Colors.white70,
                      child: Text(msg.messageText,
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic
                        
                      ),),
                    ),
                    Text(DateFormat('dd.MM.yyyy - HH:mm').format(msg.messageDateTime))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
