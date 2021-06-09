import 'package:get_it/get_it.dart';
import 'package:my_movies/services/movie_services.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<MovieService>(() => MyMovieService());
}
