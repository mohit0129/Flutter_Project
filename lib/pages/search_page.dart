import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import '../services/movie.dart';
import 'movie_details_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TMDBService tmdbService = TMDBService();
  List<Movie>? movies;
  String searchQuery = '';
  int? selectedGenre;
  Map<int, String> genres = {}; // Store genres

  //performs the search based on the search query and genre filter
  void _searchMovies() async {
    List<Movie> searchedMovies = [];

    // Only perform the search if a query exists
    if (searchQuery.isNotEmpty) {
      searchedMovies = await tmdbService.searchMovies(searchQuery);

      // Apply genre filtering if a genre is selected
      if (selectedGenre != null) {
        searchedMovies = searchedMovies
            .where((movie) => movie.genreIds.contains(selectedGenre))
            .toList();
      }
    }

    setState(() {
      movies = searchedMovies;
    });
  }

  void _fetchGenres() async {
    Map<int, String> fetchedGenres = await tmdbService.fetchGenres();
    setState(() {
      genres = fetchedGenres;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchGenres(); // Fetch genres on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
                _searchMovies(); // Trigger search immediately when query changes
              },
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Genre Dropdown Filter
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<int>(
              value: selectedGenre,
              hint: Text("Select Genre"),
              isExpanded: true,
              items: genres.entries
                  .map(
                    (entry) => DropdownMenuItem<int>(
                      value: entry.key,
                      child: Text(entry.value),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGenre = value;
                });
                _searchMovies(); // Trigger search when genre changes
              },
            ),
          ),
          Expanded(
            child: movies == null
                ? Center(child: Text('Start searching for movies...'))
                : ListView.separated(
                    itemCount: movies?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 8.0), // Add space between items
                    itemBuilder: (context, index) {
                      final movie = movies![index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        leading: Image.network(
                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(movie.title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsPage(movie: movie),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
