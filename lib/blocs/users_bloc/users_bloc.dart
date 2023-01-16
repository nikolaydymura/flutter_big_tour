import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../repositories/users_repository.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersRepository get _usersRepository => GetIt.I.get();

  UsersBloc() : super(UsersInitial()) {
    on<LoadUsersEvent>(_onLoad);
  }

  @override
  Stream<UsersState> get stream => super.stream.doOnListen(() {
        load();
      });

  void load() {
    add(LoadUsersEvent());
  }

  FutureOr<void> _onLoad(
    LoadUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    if (state is UsersInitial) {
      emit(UsersLoading());
      try {
        final users = await _usersRepository.loadUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersInitial());
      }
    }
  }
}
