import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../models/movie.dart';
import '../services/favorite_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum HomeTab { all, favorites }

class _HomeScreenState extends State<HomeScreen> {
  final FavoriteService _favoriteService = FavoriteService();
  final TextEditingController _searchController = TextEditingController();

  String _selectedGenre = 'All';
  String _searchQuery = '';
  Set<int> _favoriteIds = {};
  HomeTab _selectedTab = HomeTab.all;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final ids = await _favoriteService.getFavoriteIds();
    setState(() => _favoriteIds = ids);
  }

  Future<void> _toggleFavorite(int movieId) async {
    final ids = await _favoriteService.toggleFavorite(movieId);
    setState(() => _favoriteIds = ids);
  }

  List<Movie> get _filteredMovies {
    Iterable<Movie> result = movies;
    if (_selectedTab == HomeTab.favorites) {
      result = result.where((movie) => _favoriteIds.contains(movie.id));
    }
    if (_selectedGenre != 'All') {
      result = result.where((movie) => movie.genre == _selectedGenre);
    }
    if (_searchQuery.trim().isNotEmpty) {
      result = result.where((movie) => movie.title.toLowerCase().contains(_searchQuery.toLowerCase().trim()));
    }
    return result.toList();
  }

  void _openMovieDetail(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailScreen(
          movie: movie,
          isFavorite: _favoriteIds.contains(movie.id),
          onFavoriteTap: () => _toggleFavorite(movie.id),
        ),
      ),
    ).then((_) => _loadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    final filteredMovies = _filteredMovies;
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Explorer'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: [
              SegmentedButton<HomeTab>(
                segments: const [
                  ButtonSegment(value: HomeTab.all, label: Text('All Movies'), icon: Icon(Icons.movie)),
                  ButtonSegment(value: HomeTab.favorites, label: Text('Favorites'), icon: Icon(Icons.favorite)),
                ],
                selected: {_selectedTab},
                onSelectionChanged: (value) => setState(() => _selectedTab = value.first),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final genre = genres[index];
                    return ChoiceChip(
                      label: Text(genre),
                      selected: genre == _selectedGenre,
                      onSelected: (_) => setState(() => _selectedGenre = genre),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filteredMovies.isEmpty
                    ? Center(child: Text(_selectedTab == HomeTab.favorites ? 'No favorite movies yet.' : 'No movies found.'))
                    : ListView.builder(
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          final movie = filteredMovies[index];
                          return MovieCard(
                            movie: movie,
                            isFavorite: _favoriteIds.contains(movie.id),
                            onTap: () => _openMovieDetail(movie),
                            onFavoriteTap: () => _toggleFavorite(movie.id),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
