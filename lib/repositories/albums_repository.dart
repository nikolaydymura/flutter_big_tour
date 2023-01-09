import 'package:http/http.dart';
import 'package:untitled/network/network_api.dart';

class AlbumsRepository {
  final NetworkApi _api = NetworkApi(Client());

  String get baseUrl => const String.fromEnvironment(
        'BASE_URL',
        defaultValue: 'https://jsonplaceholder.typicode.com',
      );

  Future<List<Album>> loadAlbums(int userId) async {
    final uri = Uri.parse('$baseUrl/albums?userId=$userId');
    final items = await _api.loadJsonList(uri);
    final albums = items.map((e) => Album(e['id'], e['userId'], e['title']));
    return albums.toList();
  }
}

class Album {
  final int id;
  final int userId;
  final String title;

  Album(this.id, this.userId, this.title);
}
