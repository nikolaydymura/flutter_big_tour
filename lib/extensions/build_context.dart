import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/navigation_service.dart';

extension BuildContextX on BuildContext {
  NavigationService get navigationService => read<NavigationService>();
}
