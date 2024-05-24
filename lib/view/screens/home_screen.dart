import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodoro_app/models/history_model.dart';
import 'package:pomodoro_app/provider/category_provider.dart';
import 'package:pomodoro_app/services/history_service.dart';
import 'package:pomodoro_app/view/screens/history_screen.dart';
import 'package:pomodoro_app/view/screens/pomodoro_screen.dart';
import 'package:pomodoro_app/view/screens/select_value_screen.dart';
import 'package:pomodoro_app/view/widgets/category_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/timer_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: HexColor("153448"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HistoryScreen(),
                ));
              },
              icon: Icon(Icons.history))
        ],
      ),
      backgroundColor: HexColor("153448"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<TimerProvider>(
              builder: (context, timerProvider, child) {
                int minutes = timerProvider.timeCount * 60 ~/ 60;
                int seconds = timerProvider.timeCount * 60 % 60;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SelectValueScreen(),
                    ));
                  },
                  child: Text(
                    '$minutes:${seconds.toString().padLeft(2, '0')}',
                    style: GoogleFonts.sora()
                        .copyWith(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                isScrollControlled: false,
                context: context,
                builder: (context) => CategoryWidget(),
              ),
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      categoryProvider.title ?? 'No Category Selected',
                      style: GoogleFonts.sora()
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(8),
                child: Lottie.asset("lib/assets/animations/ani1.json",
                    controller: _controller, onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward();
                })),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PomodoroScreen(),
                ));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                backgroundColor: Color.fromRGBO(58, 68, 77, 0.49),
                foregroundColor: Colors.white,
              ),
              child: Text(
                "Start Focus",
                style: GoogleFonts.sora()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
