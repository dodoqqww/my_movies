import 'package:flutter/foundation.dart';

class MovieModel extends ChangeNotifier {
  String _search = "";

  String get search => _search;

  String _selectedFilm = "";

  String get selectedFilm => _selectedFilm;

  set selectedFilm(String id) {
    _selectedFilm = id;
  }

  pushSearch(String search) {
    _search = search;
    notifyListeners();
  }
}
