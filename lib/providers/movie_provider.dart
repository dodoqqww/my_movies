import 'package:flutter/foundation.dart';
import 'package:my_movies/services/movie_entites/error.dart';
import 'package:my_movies/services/movie_services.dart';
import 'package:my_movies/services/service_locator.dart';

class MovieProvider extends ChangeNotifier {
  Object _searchResult = new ApiError(error: "null");

  Object get searchResult => _searchResult;

  String _selectedFilm = "";

  String get selectedFilm => _selectedFilm;

  MovieService _movieService = getIt<MovieService>();

  set selectedFilm(String id) {
    _selectedFilm = id;
  }

  Future<void> fetchSearch(String search) async {
    _searchResult = await _movieService.fetchSearch(search);
    notifyListeners();
  }

  Future<Object> fetchMovie() {
    return _movieService.fetchMovie(_selectedFilm);
  }
}
