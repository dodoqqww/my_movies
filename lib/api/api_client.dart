import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_movies/api/entites/error.dart';
import 'package:my_movies/api/entites/movie_info.dart';
import 'entites/search.dart';

Future<Object> fetchSearch(String search) async {
  final response = await http.get(
      'http://www.omdbapi.com/?apikey=8a86be4e&s=$search&type&y&r&page&callback&v');

  if (response.statusCode == 200) {
    var result = SearchResult.fromJson(jsonDecode(response.body));
    if (result.response == "True") {
      return result;
    } else {
      return ApiError.fromJson(jsonDecode(response.body));
    }
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Object> fetchMovie(String id) async {
  final response =
      await http.get('http://www.omdbapi.com/?apikey=8a86be4e&i=$id&plot=full');

  if (response.statusCode == 200) {
    var result = MovieInfo.fromJson(jsonDecode(response.body));
    if (result.response == "True") {
      return result;
    } else {
      return ApiError.fromJson(jsonDecode(response.body));
    }
  } else {
    throw Exception('Failed to load data');
  }
}
