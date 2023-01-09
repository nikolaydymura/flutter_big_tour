import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/blocs/albums_bloc/albums_bloc.dart';
import 'package:untitled/extensions/build_context.dart';

class AlbumsPage extends StatelessWidget {

  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: BlocBuilder<AlbumsBloc, AlbumsState>(
        builder: (context, state) {
          if (state is AlbumsEmpty) {
            return const Center(child: Text('User needs some albums'));
          }
          if (state is AlbumsLoaded) {
            final albums = state.albums;
            return ListView.builder(
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  title: Text(album.title),
                  onTap: () {
                    context.navigationService.openPhotos(album.id);
                  },
                );
              },
              itemCount: albums.length,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
