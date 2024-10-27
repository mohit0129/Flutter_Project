import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'watchlist_provider.dart';

class WatchlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final watchlist = Provider.of<WatchlistProvider>(context).watchlist;

    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: watchlist.isEmpty
          ? Center(child: Text('Your watchlist is empty'))
          : ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                final movie = watchlist[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    width: 35,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 50);
                    },
                  ),
                  title: Text(movie.title),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      Provider.of<WatchlistProvider>(context, listen: false)
                          .removeMovie(movie);
                    },
                  ),
                );
              },
            ),
    );
  }
}
