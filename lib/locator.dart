import 'package:get_it/get_it.dart';
import 'package:untitled/repositories/albums_repository.dart';
import 'package:untitled/repositories/users_repository.dart';

final coreGetIt = GetIt.instance;

void setupLocator() {
  coreGetIt.registerLazySingleton(() => UsersRepository());
  coreGetIt.registerLazySingleton(() => AlbumsRepository());
}

