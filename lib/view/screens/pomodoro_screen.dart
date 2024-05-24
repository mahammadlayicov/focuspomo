import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_app/models/history_model.dart';
import 'package:pomodoro_app/provider/category_provider.dart';
import 'package:pomodoro_app/provider/timer_provider.dart';
import 'package:pomodoro_app/services/history_service.dart';
import 'package:pomodoro_app/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  Timer? _timer;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  int count = 0;

  Future<void> _addHistory({required bool isFinish}) async {
    final formattedDateTime =
        DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now());
    final aa = Provider.of<TimerProvider>(context, listen: false).timeCount;
    final bb = Provider.of<CategoryProvider>(context, listen: false).title;
    final value = aa * 60;
    final minutes = value ~/ 60;
    final seconds = value % 60;
    final historyService = Provider.of<HistoryService>(context, listen: false);
    print("screende elave edildi");
    await historyService.addHistory(HistoryModel(
      isFinish: isFinish,
      category: bb,
      timer: '$minutes:${seconds.toString().padLeft(2, '0')}',
      dateTime: formattedDateTime,
    ));
  }

  void _startTimer() {
    final timerData = Provider.of<TimerProvider>(context, listen: false);
    count = timerData.timeCount * 60;
    const interval = Duration(seconds: 1);
    _timer = Timer.periodic(interval, (timer) {
      if (count > 0) {
        setState(() {
          count--;
        });
      } else {
        timer.cancel();
        _addHistory(isFinish: true);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  void _resumeTimer() {
    if (_timer == null || !_timer!.isActive) {
      const interval = Duration(seconds: 1);
      _timer = Timer.periodic(interval, (timer) {
        if (count > 0) {
          setState(() {
            count--;
          });
        } else {
          timer.cancel();
          _addHistory(isFinish: true);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        }
      });
    }
  }

  Duration _tapDuration = Duration.zero;
  bool _isTapping = false;
  double _value = 0.0;

  void _startTimer1() {
    setState(() {
      _isTapping = true;
    });

    const interval = Duration(milliseconds: 100);
    Timer.periodic(interval, (timer) async {
      if (_isTapping) {
        setState(() {
          if (!isVisible) {
            isVisible = true;
          }
          if (_value < 50) {
            _value++;
          } else {
            _addHistory(isFinish: false);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
            _endTimer();
          }
        });
      } else {
        timer.cancel();
      }
      if (_tapDuration >= Duration(seconds: 5)) {
        timer.cancel();
        _isTapping = false;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        _endTimer();
      }
    });
  }

  void _endTimer() {
    setState(() {
      isVisible = false;
      _isTapping = false;
      _tapDuration = Duration.zero;
      _value = 0.0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("153448"),
      body: GestureDetector(
        onTapDown: (details) {
          _startTimer1();
        },
        onTapUp: (details) {
          _value = 0.0;
          _endTimer();
        },
        onTapCancel: () {
          _value = 0.0;
          _endTimer();
        },
        onDoubleTap: () {
          _value = 0.0;
          _endTimer();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Consumer<TimerProvider>(
              builder: (context, timerProvider, child) {
                int minutes = count ~/ 60;
                int seconds = count % 60;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Text(
                        '$minutes:${seconds.toString().padLeft(2, '0')}',
                        style: GoogleFonts.sora().copyWith(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Container(),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: 200,
                        child: Column(
                          children: [
                            Visibility(
                              visible: isVisible,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 0.0),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 0.0),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 50,
                                  value: _value,
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _value = newValue;
                                      if (_value == 50) {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ));
                                        _endTimer();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: EdgeInsets.all(_isTapping ? 10 : 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Hold To Stop Focus",
                                style: GoogleFonts.sora().copyWith(
                                  fontSize: _isTapping ? 14 : 15,
                                  color: _isTapping
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
