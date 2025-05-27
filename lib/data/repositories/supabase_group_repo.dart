import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart' as my_entities;
import 'package:demo_game_night/domain/entities/user_address.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseGroupRepo implements IGroupRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createGroup(Group newGroup) async {
    // 1. Insert group and get the new group id
    await supabase.from('groups').insert({
      'id': newGroup.id,
      'name': newGroup.name,
    });

    // 2. Insert members into GroupMembers
    for (final member in newGroup.members) {
      await supabase.from('groupmembers').insert({
        'group_id': newGroup.id,
        'user_id': member.id,
      });
    }
  }

  @override
Future<List<Group>> getGroups(my_entities.User user) async {
  // 1. Hole alle Gruppen-IDs, in denen der User Mitglied ist
  final groupIdsRes = await supabase
      .from('groupmembers')
      .select('group_id')
      .eq('user_id', user.id);

  final groupIds = (groupIdsRes as List).map((g) => g['group_id']).toList();

  if (groupIds.isEmpty) return [];

  // 2. Hole die Gruppen mit den ermittelten IDs und deren Mitglieder
  final groupsRes = await supabase
      .from('groups')
      .select('id, name, groupmembers(user_id, users(id, username, firstname, lastname))')
      .inFilter('id', groupIds);

  return (groupsRes as List).map((g) => Group(
    id: g['id'],
    name: g['name'],
    members: (g['groupmembers'] as List<dynamic>).map((gm) => my_entities.User(
      id: gm['users']['id'],
      username: gm['users']['username'],
      password: '',
      firstName: gm['users']['firstname'],
      lastName: gm['users']['lastname'],
      address: UserAddress(
        street: '',
        number: '',
        plz: '',
        location: '',
      ),
    )).toList(),
  )).toList();
}


  @override
  Future<Group> getGroupById(int groupId) async {
    final res = await supabase
        .from('groups')
        .select('id, name, groupmembers(user_id, users(id, username, firstname, lastname))')
        .eq('id', groupId)
        .maybeSingle();

    if (res == null) throw Exception('Group not found');

    return Group(
      id: res['id'],
      name: res['name'],
      members: (res['groupmembers'] as List<dynamic>).map((gm) => my_entities.User(
        id: gm['users']['id'],
        username: gm['users']['username'],
        password: '',
        firstName: gm['users']['firstname'],
        lastName: gm['users']['lastname'],
        address: UserAddress(
          street: '',
          number: '',
          plz: '',
          location: '',
        ),
      )).toList(),
    );
  }
}