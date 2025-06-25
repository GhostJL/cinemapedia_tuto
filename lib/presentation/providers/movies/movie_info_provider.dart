import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, dynamic>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

/*
{
'574475': Movie(),
'574476': Movie(),
'574477': Movie(),
}
*/

typedef GetMovieCallBack = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
