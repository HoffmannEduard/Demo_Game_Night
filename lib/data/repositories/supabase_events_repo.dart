import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/user.dart' as app;
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseEventsRepo implements IEventsRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createEvent(GameNightEvent newEvent) async {
    await supabase.from('events').insert({
      'name': newEvent.name,
      'group_id': newEvent.groupId,
      'host_id': newEvent.host.id,
      'date': newEvent.date.toIso8601String(),
      'recurrence': newEvent.recurrence,
      'is_past': newEvent.isPast,
    });
  }

  @override
  Future<List<GameNightEvent>> getUpcomingEvents(app.User user) async {
    final groupRes = await supabase
        .from('group_members')
        .select('group_id')
        .eq('user_id', user.id);

    final groupIds = (groupRes as List).map((g) => g['group_id']).toList();

    final eventsRes = await supabase
        .from('events')
        .select('id, name, group_id, host_id, date, recurrence, is_past')
        .inFilter('group_id', groupIds)
        .eq('is_past', false);

    return (eventsRes as List).map((e) => GameNightEvent(
      id: e['id'],
      name: e['name'],
      groupId: e['group_id'],
      host: user,
      date: DateTime.parse(e['date']),
      recurrence: e['recurrence'],
      isPast: e['is_past'],
    )).toList();
  }

  @override
  Future<List<GameNightEvent>> getPastEvents(app.User user) async {
    final groupRes = await supabase
        .from('group_members')
        .select('group_id')
        .eq('user_id', user.id);

    final groupIds = (groupRes as List).map((g) => g['group_id']).toList();

    final eventsRes = await supabase
        .from('events')
        .select('id, name, group_id, host_id, date, recurrence, is_past')
        .inFilter('group_id', groupIds)
        .eq('is_past', true);

    return (eventsRes as List).map((e) => GameNightEvent(
      id: e['id'],
      name: e['name'],
      groupId: e['group_id'],
      host: user,
      date: DateTime.parse(e['date']),
      recurrence: e['recurrence'],
      isPast: e['is_past'],
    )).toList();
  }

  @override
  Future<void> updateEvent(GameNightEvent updatedEvent) async {
    await supabase.from('events').update({
      'name': updatedEvent.name,
      'group_id': updatedEvent.groupId,
      'host_id': updatedEvent.host.id,
      'date': updatedEvent.date.toIso8601String(),
      'recurrence': updatedEvent.recurrence,
      'is_past': updatedEvent.isPast,
    }).eq('id', updatedEvent.id);
  }
}