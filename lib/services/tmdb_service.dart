import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart';

class TMDBService {
  final String apiKey = '18855e58ef2c4e0b9d046944e12ca433';
  final String baseUrl = 'https://api.themoviedb.org/3';

  // Fetches popular movies with pagination
  Future<List<Movie>> fetchMovies(int page) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=$page'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List movies = data['results'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Searches movies based on a query
  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List movies = data['results'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }

  // Fetches the list of genres
  Future<Map<int, String>> fetchGenres() async {
    final response = await http.get(
      Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey&language=en-US'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List genres = data['genres'];
      return {for (var genre in genres) genre['id']: genre['name']};
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<Movie> fetchMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("API Response: $jsonData"); // Debug print

      return Movie.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
