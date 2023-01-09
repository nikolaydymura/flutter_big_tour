import 'package:flutter/cupertino.dart';

import 'navigation_args.dart';
import 'navigation_routes.dart';

export 'navigation_args.dart';
export 'navigation_routes.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey;

  NavigationService(this._navigationKey);

  void openHome() {
    _navigationKey.currentState?.pushNamed(kHomeRoute);
  }

  void openUsers() {
    _navigationKey.currentState?.pushNamed(kUsersRoute);
  }

  void openAlbums(int userId) {
    _navigationKey.currentState?.pushNamed(kAlbumsRoute, arguments: userId);
  }

  void openPhotos(int albumId) {
    _navigationKey.currentState?.pushNamed(kPhotosRoute, arguments: albumId);
  }
}
