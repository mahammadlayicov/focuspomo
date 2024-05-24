import 'package:flutter/material.dart';
import 'package:pomodoro_app/provider/category_provider.dart';
import 'package:pomodoro_app/provider/timer_provider.dart';
import 'package:pomodoro_app/services/history_service.dart';
import 'package:provider/provider.dart';
import 'view/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TimerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryService(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: HomeScreen()),
    );
  }
}
