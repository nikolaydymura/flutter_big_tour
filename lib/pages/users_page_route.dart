import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users_bloc/users_bloc.dart';
import 'users_page.dart';

// inject dependencies
class UsersPageRoute extends StatelessWidget {
  const UsersPageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersBloc>(
      create: (context) {
        return UsersBloc();
      },
      child: const UsersPage(),
    );
  }
}
