import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _key = 'favorite_movie_ids';

  Future<Set<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    return ids.map(int.parse).toSet();
  }

  Future<void> saveFavoriteIds(Set<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, ids.map((id) => id.toString()).toList());
  }

  Future<Set<int>> toggleFavorite(int movieId) async {
    final ids = await getFavoriteIds();
    if (ids.contains(movieId)) {
      ids.remove(movieId);
    } else {
      ids.add(movieId);
    }
    await saveFavoriteIds(ids);
    return ids;
  }
}
