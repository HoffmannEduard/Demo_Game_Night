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
    final groupInsert = await supabase.from('groups').insert({
      'name': newGroup.name,
    }).select().single();

    final groupId = groupInsert['id'];

    // 2. Insert members into GroupMembers
    for (final member in newGroup.members) {
      await supabase.from('groupmembers').insert({
        'group_id': groupId,
        'user_id': member.id,
      });
    }
  }

  @override
  Future<List<Group>> getGroups(my_entities.User user) async {
    final data = await supabase
        .from('groups')
        .select('id, name, groupmembers(user_id, users(id, username, firstname, lastname))');

    return (data as List<dynamic>).map((g) => Group(
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