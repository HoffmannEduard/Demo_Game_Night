import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/user.dart' as app;
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseEventsRepo implements IEventsRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createEvent(GameNightEvent newEvent) async {
    await supabase.from('gamenightevent').insert({
      'name': newEvent.name,
      'groupid': newEvent.groupId,
      'hostid': newEvent.host.id,
      'date': newEvent.date.toIso8601String(),
      'recurrence': newEvent.recurrence,
      'ispast': newEvent.isPast,
    });
  }

  @override
  Future<List<GameNightEvent>> getUpcomingEvents(app.User user) async {
    final groupRes = await supabase
        .from('group_members')
        .select('groupid')
        .eq('user_id', user.id);

    final groupIds = (groupRes as List).map((g) => g['group_id']).toList();

    final eventsRes = await supabase
        .from('gamenightevent')
        .select('id, name, groupid, hostid, date, recurrence, ispast')
        .inFilter('groupid', groupIds)
        .eq('ispast', false);

    return (eventsRes as List).map((e) => GameNightEvent(
      id: e['id'],
      name: e['name'],
      groupId: e['groupid'],
      host: user,
      date: DateTime.parse(e['date']),
      recurrence: e['recurrence'],
      isPast: e['ispast'],
    )).toList();
  }

  @override
  Future<List<GameNightEvent>> getPastEvents(app.User user) async {
    final groupRes = await supabase
        .from('group_members')
        .select('groupid')
        .eq('user_id', user.id);

    final groupIds = (groupRes as List).map((g) => g['group_id']).toList();

    final eventsRes = await supabase
        .from('gamenightevent')
        .select('id, name, groupid, hostid, date, recurrence, ispast')
        .inFilter('group_id', groupIds)
        .eq('ispast', true);

    return (eventsRes as List).map((e) => GameNightEvent(
      id: e['id'],
      name: e['name'],
      groupId: e['groupid'],
      host: user,
      date: DateTime.parse(e['date']),
      recurrence: e['recurrence'],
      isPast: e['ispast'],
    )).toList();
  }

  @override
  Future<void> updateEvent(GameNightEvent updatedEvent) async {
    await supabase.from('gamenightevent').update({
      'name': updatedEvent.name,
      'groupid': updatedEvent.groupId,
      'hostid': updatedEvent.host.id,
      'date': updatedEvent.date.toIso8601String(),
      'recurrence': updatedEvent.recurrence,
      'ispast': updatedEvent.isPast,
    }).eq('id', updatedEvent.id);
  }
}