import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyAPI {
  static const String _baseUrl = "https://api.spotify.com/v1/";

  // Function to fetch artists by language/region (using genres or search queries based on language)
  Future<Map<String, List<Map<String, String>>>> fetchArtistsByLanguage(String language, String accessToken) async {
    final Map<String, List<Map<String, String>>> artistData = {};

    // Perform a search query based on the language
    final query = language == 'International' ? 'genre:pop' : 'genre:$language';
    final response = await _getArtists(query, accessToken);

    if (response != null && response['artists'] != null) {
      final artistsList = response['artists']['items'];
      final List<Map<String, String>> artists = artistsList.map<Map<String, String>>((artist) {
        return {
          'name': artist['name'],
          'image': artist['images']?.isNotEmpty ?? false
              ? artist['images'][0]['url']
              : 'assets/default_image.png', // Fallback image if none exists
        };
      }).toList();

      artistData[language] = artists;
    }

    return artistData;
  }

  // Helper method to send GET request to Spotify
  Future<Map<String, dynamic>?> _getArtists(String query, String accessToken) async {
    final url = Uri.parse('${_baseUrl}search?q=$query&type=artist&limit=10'); // Adjust query params as needed
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken', // Use the access token directly
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to load artists. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load artists from Spotify');
    }
  }
}
