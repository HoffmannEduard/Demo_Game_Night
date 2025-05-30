import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/user.dart' as app;
import 'package:demo_game_night/domain/entities/user_address.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseEventsRepo implements IEventsRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createEvent(GameNightEvent newEvent) async {
    await supabase.from('gamenightevent').insert({
      'id': newEvent.id,
      'name': newEvent.name,
      'group_id': newEvent.groupId,
      'host_id': newEvent.host.id,
      'date': newEvent.date.toIso8601String(),
      'recurrence': newEvent.recurrence,
      'ispast': newEvent.isPast,
    });
  }

  @override
  Future<List<GameNightEvent>> getUpcomingEvents(app.User user) async {
    final groupRes = await supabase
        .from('groupmembers')
        .select('group_id')
        .eq('user_id', user.id);

    final groupIds = (groupRes as List).map((g) => g['group_id']).toList();

    if (groupIds.isEmpty) return [];

    final eventsRes = await supabase
        .from('gamenightevent')
        .select('id, name, group_id, host_id, date, recurrence, ispast, host:users(id, username, firstname, lastname)')
        .inFilter('group_id', groupIds)
        .eq('ispast', false);

    return (eventsRes as List).map((e) => GameNightEvent(
      id: e['id'],
      name: e['name'],
      groupId: e['group_id'],
      host: app.User(
        id: e['host']['id'], 
        username: e['host']['username'], 
        password: '', 
        firstName: e['host']['firstname'], 
        lastName: e['host']['lastname'], 
        address: UserAddress(
          plz: '', 
          street: '', 
          number: '', 
          location: '')),
      date: DateTime.parse(e['date']),
      recurrence: e['recurrence'],
      isPast: e['ispast'],
    )).toList();
  }

  @override
  Future<List<GameNightEvent>> getPastEvents(app.User user) async {
    final groupRes = await supabase
        .from('groupmembers')
        .select('group_id')
        .eq('user_id', user.id);

    final groupIds = (groupRes as List).map((g) => g['group_id']).toList();

    if (groupIds.isEmpty) return [];

    final eventsRes = await supabase
        .from('gamenightevent')
        .select('id, name, group_id, host_id, date, recurrence, ispast, host:users(id, username, firstname, lastname)')
        .inFilter('group_id', groupIds)
        .eq('ispast', true);

    return (eventsRes as List).map((e) => GameNightEvent(
      id: e['id'],
      name: e['name'],
      groupId: e['group_id'],
      host: app.User(
        id: e['host']['id'],
        username: e['host']['username'],
        password: '',
        firstName: e['host']['firstname'],
        lastName: e['host']['lastname'],
        address: UserAddress(
          plz: '',
          street: '',
          number: '',
          location: '',
        ),
      ),
      date: DateTime.parse(e['date']),
      recurrence: e['recurrence'],
      isPast: e['ispast'],
    )).toList();
  }

  @override
  Future<void> updateEvent(GameNightEvent updatedEvent) async {
    await supabase.from('gamenightevent').update({
      'name': updatedEvent.name,
      'group_id': updatedEvent.groupId,
      'host_id': updatedEvent.host.id,
      'date': updatedEvent.date.toIso8601String(),
      'recurrence': updatedEvent.recurrence,
      'ispast': updatedEvent.isPast,
    }).eq('id', updatedEvent.id);
  }
}