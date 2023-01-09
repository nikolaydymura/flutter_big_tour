part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

// coverage:ignore-start
  @override
  List<Object?> get props => [];
// coverage:ignore-end
}

class LoadUsersEvent extends UsersEvent {}
