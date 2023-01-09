part of 'albums_bloc.dart';

abstract class AlbumsEvent extends Equatable {
  const AlbumsEvent();

// coverage:ignore-start
  @override
  List<Object?> get props => [];
// coverage:ignore-end
}

class LoadAlbumsEvent extends AlbumsEvent {}
