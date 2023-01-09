import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/extensions/build_context.dart';
import 'package:untitled/locator.dart';
import 'package:untitled/services/navigation_service.dart';

void main() {
  setupLocator();
  runApp(MyApp());
  /*runApp(
    Container(
      color: Colors.white,
      child: CustomPaint(
        size: Size(100, 100),
        painter: _Painter(
          petals: [
            PetalInfo(Colors.red, filled: 0.5),
            PetalInfo(Colors.green),
            PetalInfo(Colors.blue)
          ],
        ),
      ),
    ),
  );*/
}

class PetalInfo {
  final Paint outerPaint;
  final Paint innerPaint;
  final double filled;

  PetalInfo(Color color, {this.filled = 0, double strokeWidth = 1.0})
      : outerPaint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round,
        innerPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
}

class _Painter extends CustomPainter {
  final petal = const Size(130, 160);
  double get petalRadius => petal.height * 1.3;
  final List<PetalInfo> petals;

  _Painter({required this.petals});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = petal.height;
    final patelStep = 2 * pi / petals.length;
    for (var i = 0; i < petals.length; i++) {
      final angle = pi / 2 + i * patelStep;

      final path = _buildPetal(
          canvas, center, outerRadius, angle, petalRadius.toDouble());

      //final petalEnd = center - Offset(x, y);
      //canvas.drawLine(center, petalEnd, _paint!);

      canvas.drawPath(path, petals[i].outerPaint);
      if (petals[i].filled > 0.0) {
        final innerRadius = petal.height * petals[i].filled;
        final path = _buildPetal(
          canvas,
          center,
          innerRadius,
          angle,
          petalRadius * petals[i].filled,
        );
        canvas.drawPath(path, petals[i].innerPaint);
      }
    }
  }

  Path _buildPetal(Canvas canvas,
      Offset start,
      double radius,
      double angle,
      double controlRadius,) {
    Path path = Path();
    final end = start - Offset(cos(angle) * radius, sin(angle) * radius);

    final c1X = cos(angle - pi / 4.5) * controlRadius;
    final c1Y = sin(angle - pi / 4.5) * controlRadius;

    final leftPoint = start - Offset(c1X, c1Y);

    path.moveTo(start.dx, start.dy);
    path.quadraticBezierTo(
      leftPoint.dx,
      leftPoint.dy,
      end.dx,
      end.dy,
    );
    path.moveTo(start.dx, start.dy);

    final c2X = cos(angle + pi / 4.5) * controlRadius;
    final c2Y = sin(angle + pi / 4.5) * controlRadius;
    final rightPoint = start - Offset(c2X, c2Y);

    path.quadraticBezierTo(
      rightPoint.dx,
      rightPoint.dy,
      end.dx,
      end.dy,
    );
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
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
