// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/blocs/users_bloc/users_bloc.dart';
import 'package:untitled/locator.dart';
import 'package:untitled/repositories/users_repository.dart';

import 'generated.mocks.dart';

void main() {
  late MockUsersRepository mockUsersRepository;
  setupLocator();
  setUp(() {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerLazySingleton<UsersRepository>(
      () => mockUsersRepository,
    );
    mockUsersRepository = MockUsersRepository();
    when(mockUsersRepository.loadUsers()).thenAnswer((_) async => []);
  });
  tearDown(() {
    verifyNoMoreInteractions(mockUsersRepository);
  });
  blocTest<UsersBloc, UsersState>(
    'initial loading no users',
    build: () => UsersBloc(),
    wait: const Duration(milliseconds: 100),
    act: (bloc) {},
    expect: () => [
      isA<UsersLoading>(),
      isA<UsersLoaded>().having((p0) => p0.users.length, 'no users', equals(0)),
    ],
    verify: (bloc) {
      verify(mockUsersRepository.loadUsers()).called(1);
    },
  );

  blocTest<UsersBloc, UsersState>(
    'initial loading found one user',
    setUp: () {
      when(mockUsersRepository.loadUsers())
          .thenAnswer((_) async => [User(0, 'Bob')]);
    },
    build: () => UsersBloc(),
    wait: const Duration(milliseconds: 100),
    act: (bloc) {},
    expect: () => [
      isA<UsersLoading>(),
      isA<UsersLoaded>().having((p0) => p0.users.length, 'single', equals(1)),
    ],
    verify: (bloc) {
      verify(mockUsersRepository.loadUsers()).called(1);
    },
  );

  blocTest<UsersBloc, UsersState>(
    'initial loading failed',
    setUp: () {
      when(mockUsersRepository.loadUsers()).thenThrow('Oops!!!');
    },
    build: () => UsersBloc(),
    wait: const Duration(milliseconds: 100),
    act: (bloc) {},
    expect: () => [
      isA<UsersLoading>(),
      isA<UsersInitial>(),
    ],
    verify: (bloc) {
      verify(mockUsersRepository.loadUsers()).called(1);
    },
  );

  blocTest<UsersBloc, UsersState>(
    'load when user loading',
    build: () => UsersBloc(),
    seed: () => UsersLoading(),
    wait: const Duration(milliseconds: 100),
    act: (bloc) {
      bloc.load();
    },
    expect: () => [],
    verify: (bloc) {
      verifyNever(mockUsersRepository.loadUsers());
    },
  );

  blocTest<UsersBloc, UsersState>(
    'load when users already loaded',
    build: () => UsersBloc(),
    seed: () => const UsersLoaded(<User>[]),
    wait: const Duration(milliseconds: 100),
    act: (bloc) {
      bloc.load();
    },
    expect: () => [],
    verify: (bloc) {
      verifyNever(mockUsersRepository.loadUsers());
    },
  );
}
