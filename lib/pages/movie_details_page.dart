import 'package:flutter/material.dart';
import '../services/movie.dart';
import 'package:provider/provider.dart';
import '../watchlist/watchlist_provider.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  MovieDetailsPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Movie Poster
            Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
            SizedBox(height:10),
            Image.network(
                'https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
            SizedBox(height: 16),

            // Text("Tagline: ${movie.tagLine}",
            //     style: const TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 6),

            // Movie Overview
            Text("Overview:",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(movie.overview),
            SizedBox(height: 14),

            // Release Date
            Text("Release Date: ${movie.releaseDate}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),

            // Language
            Text("Language: ${movie.language}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            
            // // Vote Average
            Text("Vote Average: ${movie.voteAverage}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),

            // // Vote Count
            Text("Vote Count: ${movie.voteCount}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),

            // Budget
            // Text("Budget: \$${movie.budgets}",
            //     style: const TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 6),

            // Revenue
            // Text("Revenue: \$${movie.revenues}",
            //     style: const TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 6),

            // // Origin Country
            // Text("Origin Country: ${movie.originCountry}",
            //     style: const TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 6),

            // // Status
            // Text("Status: ${movie.status}",
            //     style: const TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 6),

            // Text("Runtime: ${movie.runTime}",
            //     style: const TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 6),

            // Text("Genre: ${movie.genre}",
            //     style: const TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 6),

            // Text("Language: ${movie.spokenLanguages}",
            //     style: const TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 6),

            // Add to Watchlist Button
            ElevatedButton(
              onPressed: () {
                Provider.of<WatchlistProvider>(context, listen: false)
                    .addMovie(movie);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${movie.title} added to watchlist!')),
                );
              },
              child: Text('Add to Watchlist'),
            ),
          ],
        ),
      ),
    );
  }
}
