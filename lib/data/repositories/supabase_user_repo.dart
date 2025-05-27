import 'package:demo_game_night/domain/entities/user.dart' as my_entities;
import 'package:demo_game_night/domain/entities/user_address.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUserRepo implements IUserRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addUser(my_entities.User user) async {
    final addressInsert = await supabase.from('useraddress').insert({
      'plz': user.address.plz,
      'street': user.address.street,
      'number': user.address.number,
      'location': user.address.location,
    }).select().single();

    final addressId = addressInsert['id'];

    await supabase.from('users').insert({
      'id': user.id,
      'username': user.username,
      'password': user.password,
      'firstname': user.firstName,
      'lastname': user.lastName,
      'address_id': addressId,
    });
  }

  @override
  Future<my_entities.User?> getUser(String username, String password) async {
    final res = await supabase
        .from('users')
        .select('id, username, password, firstname, lastname, address_id, useraddress!users_address_id_fkey (plz, street, number, location)')
        .eq('username', username)
        .eq('password', password)
        .maybeSingle();

    if (res == null) return null;

    final address = res['useraddress'];
    return my_entities.User(
      id: res['id'],
      username: res['username'],
      password: res['password'],
      firstName: res['firstname'],
      lastName: res['lastname'],
      address: address != null
          ? UserAddress(
              plz: address['plz'],
              street: address['street'],
              number: address['number'],
              location: address['location'],
            )
          : UserAddress(plz: '', street: '', number: '', location: ''),
    );
  }

  @override
  Future<bool> userExists(String username) async {
    final res = await supabase
        .from('users')
        .select('id')
        .eq('username', username)
        .maybeSingle();
    return res != null;
  }

  @override
  Future<my_entities.User?> getUserByUsername(String username) async {
    final res = await supabase
        .from('users')
        .select('id, username, password, firstname, lastname, address_id, useraddress!users_address_id_fkey (plz, street, number, location)')
        .eq('username', username)
        .maybeSingle();

    if (res == null) return null;

    final address = res['useraddress'];
    return my_entities.User(
      id: res['id'],
      username: res['username'],
      password: res['password'],
      firstName: res['firstname'],
      lastName: res['lastname'],
      address: address != null
          ? UserAddress(
              plz: address['plz'],
              street: address['street'],
              number: address['number'],
              location: address['location'],
            )
          : UserAddress(plz: '', street: '', number: '', location: ''),
    );
  }
}