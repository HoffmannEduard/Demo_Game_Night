import 'package:demo_game_night/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class GameNightEvent extends Equatable {
  final int id;
  final String name;
  final int groupId;
  final User host;
  final DateTime date;
  final int recurrence;
  final bool isPast;

  
const GameNightEvent({
 required this.id,
 required this.name,
 required this.groupId,
 required this.host,
 required this.date,
 required this.recurrence,
 required this.isPast,
});

GameNightEvent copyWith({
    int? id,
    String? name,
    int? groupId,
    User? host,
    DateTime? date,
    int? recurrence,
    bool? isPast,
  }) {
    return GameNightEvent(
      id: id ?? this.id,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      host: host ?? this.host,
      date: date ?? this.date,
      recurrence: recurrence ?? this.recurrence,
      isPast: isPast ?? this.isPast,
    );
  }
  
  @override
  List<Object?> get props => [id, name, groupId, host, date, recurrence, isPast];
}