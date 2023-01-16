import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/extensions/build_context.dart';
import 'package:untitled/locator.dart';
import 'package:untitled/services/navigation_service.dart';

void main() {
  setupLocator();
}

class MyApp extends StatelessWidget {
  late final GlobalKey<NavigatorState> _navigationKey = GlobalKey();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NavigationService(_navigationKey),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigationKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.purple,
        ),
        routes: appRoutes,
        initialRoute: '/users',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Message {
  final String text;

  Message(this.text);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              context.navigationService.openHome();
            },
            tooltip: 'Home',
            child: const Icon(Icons.home),
          ),
          FloatingActionButton(
            onPressed: () {
              //context.navigationService.openConversations(ConversationsArgs('orderType'));
            },
            tooltip: 'Friends',
            child: const Icon(Icons.people),
          ),
        ],
      ),
    );
  }
}
