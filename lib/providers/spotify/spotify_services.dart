import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  final String clientId = '5ac0be1a7182430da76690f6a85bb72e';
  final String clientSecret = '67c9854fe1b148fa858f3a983a58455b';
  String? accessToken;

  // Get Spotify Access Token
  Future<void> authenticate() async {
    final String credentials = '$clientId:$clientSecret';
    final String encodedCredentials = base64Encode(utf8.encode(credentials));

    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic $encodedCredentials',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      accessToken = data['access_token'];
    } else {
      throw Exception('Failed to authenticate with Spotify API');
    }
  }

  // Get Artists by Genre or Query
  Future<List<String>> fetchArtists(String query) async {
    if (accessToken == null) {
      await authenticate();
    }

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/search?q=$query&type=artist&limit=50'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> artists = data['artists']['items'];
      return artists.map<String>((artist) => artist['name'] as String).toList();
    } else {
      throw Exception('Failed to fetch artists from Spotify API');
    }
  }
}
