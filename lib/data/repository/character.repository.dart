import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ygroup/data/entity/character.entity.dart';
import 'package:ygroup/data/entity/episode.entity.dart';

class CharacterRepository {
  static const _api = "https://rickandmortyapi.com/api";

  static Future<List<Character>> getCharacterList({
    required int page,
  }) async {
    try {
      final url = "$_api/character?page=$page";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final results = jsonData['results'] as List;
        final list = results.map((e) => Character.fromJson(e)).toList();

        return list;
      }
      throw ("Code: ${response.statusCode}");
    } catch (error, stacktrace) {
      throw ("Error: $error, $stacktrace");
    }
  }

  static Future<Episode> getEpisode({
    required String url,
  }) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return Episode.fromJson(jsonData);
      }
      throw ("Code: ${response.statusCode}");
    } catch (error, stacktrace) {
      throw ("Error: $error, $stacktrace");
    }
  }
}
