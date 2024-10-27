import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import '../services/movie.dart';
import 'movie_details_page.dart';
import '../watchlist/watchlist_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TMDBService tmdbService = TMDBService();
  List<Movie>? movies = [];
  int currentPage = 1; // Track the current page
  bool isLoading = false; // Track loading state
  bool hasMoreMovies = true; // Check if there are more movies to load

  void _fetchMovies() async {
    if (isLoading || !hasMoreMovies) return; // Prevent multiple requests

    setState(() {
      isLoading = true; // Set loading state
    });

    try {
      List<Movie> fetchedMovies = await tmdbService.fetchMovies(currentPage);
      setState(() {
        movies!.addAll(fetchedMovies); // Append new movies to the list
        currentPage++; // Increment the page for the next fetch
        hasMoreMovies =
            fetchedMovies.isNotEmpty; // Check if more movies are available
      });
    } catch (error) {
      // Handle error here
      print('Error fetching movies: $error');
    } finally {
      setState(() {
        isLoading = false; // Reset loading state
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WatchlistPage()),
              );
            },
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          // Check if we are at the bottom of the list
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _fetchMovies(); // Load more movies
          }
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount:
                movies!.length + (isLoading ? 1 : 0), // Add loading indicator
            itemBuilder: (context, index) {
              if (index < movies!.length) {
                final movie = movies![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsPage(movie: movie),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 0.7,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // Show a loading indicator at the end of the list
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
