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
      print("wow start getCharacterList");
      final url = "$_api/character?page=$page";
      final response = await http.get(Uri.parse(url));
      print("wow status code ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final results = jsonData['results'] as List;
        print("wow results length: ${results.length}");

        final list = results.map((e) => Character.fromJson(e)).toList();
        print("wow list length: ${list.length}");
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
      print("wow start getEpisode");
      final response = await http.get(Uri.parse(url));
      print("wow status code ${response.statusCode}");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("wow  jsonData $jsonData");

        return Episode.fromJson(jsonData);
      }
      throw ("Code: ${response.statusCode}");
    } catch (error, stacktrace) {
      throw ("Error: $error, $stacktrace");
    }
  }
}
