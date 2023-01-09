import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/blocs/albums_bloc/albums_bloc.dart';
import 'package:untitled/pages/albums_page.dart';
import 'package:untitled/pages/photos_page.dart';
import 'package:untitled/pages/users_page_route.dart';
import 'package:untitled/services/navigation_args.dart';

const kHomeRoute = '/home';
const kUsersRoute = '/users';
const kAlbumsRoute = '/albums';
const kPhotosRoute = '/photos';

final appRoutes = {
  kHomeRoute: (context) => Container(
        color: Colors.red,
      ),
  kAlbumsRoute: (context) {
    final userId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) => AlbumsBloc(userId),
      child: const AlbumsPage(),
    );
  },
  kPhotosRoute: (context) {
    final albumId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) => AlbumsBloc(albumId),
      child: const PhotosPage(),
    );
  },
  kUsersRoute: (context) => const UsersPageRoute()
};
