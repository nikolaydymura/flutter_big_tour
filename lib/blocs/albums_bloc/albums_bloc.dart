import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:untitled/repositories/albums_repository.dart';

part 'albums_event.dart';

part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsRepository get _albumsRepository => GetIt.I.get();
  final int _userId;

  AlbumsBloc(this._userId) : super(AlbumsInitial()) {
    on<LoadAlbumsEvent>(_onLoad);
  }

  @override
  Stream<AlbumsState> get stream => super.stream.doOnListen(() {
        load();
      });

  void load() {
    add(LoadAlbumsEvent());
  }

  FutureOr<void> _onLoad(
    LoadAlbumsEvent event,
    Emitter<AlbumsState> emit,
  ) async {
    if (state is AlbumsInitial) {
      emit(AlbumsLoading());
      try {
        final albums = await _albumsRepository.loadAlbums(_userId);
        if (albums.isEmpty) {
          emit(AlbumsEmpty());
        } else {
          emit(AlbumsLoaded(albums));
        }
      } catch (e) {
        emit(AlbumsFailed(e.toString()));
      }
    }
  }
}
