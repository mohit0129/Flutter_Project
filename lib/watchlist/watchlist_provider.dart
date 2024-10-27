import 'package:flutter/material.dart';
import '../services/movie.dart';

class WatchlistProvider with ChangeNotifier {
  List<Movie> _watchlist = [];

  List<Movie> get watchlist => _watchlist;

  void addMovie(Movie movie) {
    _watchlist.add(movie);
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    _watchlist.remove(movie);
    notifyListeners();
  }
}
