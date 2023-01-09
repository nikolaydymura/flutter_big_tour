import 'package:http/http.dart';
import 'package:untitled/network/network_api.dart';

class UsersRepository {
  final NetworkApi _api = NetworkApi(Client());

  String get baseUrl => const String.fromEnvironment(
        'BASE_URL',
        defaultValue: 'https://jsonplaceholder.typicode.com',
      );

  Future<List<User>> loadUsers() async {
    final uri = Uri.parse('$baseUrl/users');
    final items = await _api.loadJsonList(uri);
    final users = items.map((e) => User(e['id'], e['name']));
    return users.toList();
  }
}

class User {
  final int id;
  final String name;

  User(this.id, this.name);
}
