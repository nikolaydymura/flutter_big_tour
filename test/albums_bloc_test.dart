import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/blocs/albums_bloc/albums_bloc.dart';
import 'package:untitled/locator.dart';
import 'package:untitled/repositories/albums_repository.dart';

import 'generated.mocks.dart';

void main() {
  late MockAlbumsRepository mockAlbumsRepository;
  setupLocator();
  setUp(() {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerLazySingleton<AlbumsRepository>(() => mockAlbumsRepository);
    mockAlbumsRepository = MockAlbumsRepository();
    when(mockAlbumsRepository.loadAlbums(any)).thenAnswer((_) async => []);
  });
  tearDown(() {
    verifyNoMoreInteractions(mockAlbumsRepository);
  });
  blocTest<AlbumsBloc, AlbumsState>(
    'initial loading no albums',
    build: () => AlbumsBloc(0),
    wait: const Duration(milliseconds: 100),
    act: (bloc) {},
    expect: () => [isA<AlbumsLoading>(), isA<AlbumsEmpty>()],
    verify: (bloc) {
      verify(mockAlbumsRepository.loadAlbums(0)).called(1);
    },
  );

  blocTest<AlbumsBloc, AlbumsState>(
    'initial loading failed',
    setUp: () {
      when(mockAlbumsRepository.loadAlbums(any)).thenThrow('Oops!!!');
    },
    build: () => AlbumsBloc(0),
    wait: const Duration(milliseconds: 100),
    act: (bloc) {},
    expect: () => [
      isA<AlbumsLoading>(),
      isA<AlbumsFailed>()
          .having((p0) => p0.message, 'error message', 'Oops!!!'),
    ],
    verify: (bloc) {
      verify(mockAlbumsRepository.loadAlbums(0)).called(1);
    },
  );

  blocTest<AlbumsBloc, AlbumsState>(
    'initial loading found one album',
    setUp: () {
      when(mockAlbumsRepository.loadAlbums(any))
          .thenAnswer((_) async => [Album(1010, 0, 'First')]);
    },
    build: () => AlbumsBloc(20),
    wait: const Duration(milliseconds: 100),
    act: (bloc) {},
    expect: () => [
      isA<AlbumsLoading>(),
      isA<AlbumsLoaded>()
          .having((p0) => p0.albums.single.id, 'single', equals(1010)),
    ],
    verify: (bloc) {
      verify(mockAlbumsRepository.loadAlbums(20)).called(1);
    },
  );
}
