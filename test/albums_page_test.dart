// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/blocs/albums_bloc/albums_bloc.dart';
import 'package:untitled/locator.dart';
import 'package:untitled/pages/albums_page.dart';
import 'package:untitled/repositories/albums_repository.dart';

import 'generated.mocks.dart';

void main() {
  final AutomatedTestWidgetsFlutterBinding binding =
      AutomatedTestWidgetsFlutterBinding();
  late MockAlbumsRepository mockAlbumsRepository;
  setupLocator();
  setUp(() {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerLazySingleton<AlbumsRepository>(() => mockAlbumsRepository);
    mockAlbumsRepository = MockAlbumsRepository();
    when(mockAlbumsRepository.loadAlbums(any)).thenAnswer((_) async => []);
  });
  tearDown(() {
    verify(mockAlbumsRepository.loadAlbums(any)).called(1);
    verifyNoMoreInteractions(mockAlbumsRepository);
  });
  group('AlbumsPage', () {
    testWidgets('page loading', (tester) async {
      when(mockAlbumsRepository.loadAlbums(any)).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 200));
        return [];
      });
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => AlbumsBloc(1),
            child: const AlbumsPage(),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      final progressFinder = find.byType(CircularProgressIndicator);
      expect(progressFinder, findsOneWidget);
      await tester.pump(const Duration(milliseconds: 200));
    });
    testWidgets('page empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => AlbumsBloc(1),
            child: const AlbumsPage(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('albums_page_empty.png'),
      );
    });
    testWidgets('page with single element', (tester) async {
      when(mockAlbumsRepository.loadAlbums(any)).thenAnswer((_) async {
        return [Album(1010, 0, 'First album')];
      });
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => AlbumsBloc(1),
            child: const AlbumsPage(),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      final emptyWidgetFinder = find.text('First album');
      expect(emptyWidgetFinder, findsOneWidget);
    });
  });
}
