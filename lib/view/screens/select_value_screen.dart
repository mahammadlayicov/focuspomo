import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pomodoro_app/provider/category_provider.dart';
import 'package:pomodoro_app/provider/timer_provider.dart';
import 'package:pomodoro_app/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SelectValueScreen extends StatefulWidget {
  const SelectValueScreen({super.key});

  @override
  State<SelectValueScreen> createState() => _SelectValueScreenState();
}

class _SelectValueScreenState extends State<SelectValueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("153448"),
      appBar: AppBar(
        backgroundColor: HexColor("153448"),
      ),
      body: Center(
        child: Consumer<TimerProvider>(
          builder: (context, timerProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: AnimatedContainer(
                  duration: Duration(milliseconds: 800), // Animasyon süresi
                  width: timerProvider.timeCount > 5
                      ? timerProvider.timeCount.toDouble() + 75
                      : 75,
                  height: timerProvider.timeCount > 5
                      ? timerProvider.timeCount.toDouble() + 75
                      : 75,
                  child: Image.asset("lib/assets/images/logo.png"),
                )),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${timerProvider.timeCount.toString()}',
                        style: GoogleFonts.sora().copyWith(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " mins",
                        style: GoogleFonts.sora().copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Slider(
                    max: 90,
                    min: 5,
                    divisions: 17,
                    value: timerProvider.timeCount.toDouble(),
                    onChanged: (double value) {
                      timerProvider.timeCountAdd(value.toInt());
                    },
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      backgroundColor: Colors.white,
                      foregroundColor: HexColor("153448"),
                    ),
                    child: Text(
                      "Done",
                      style: GoogleFonts.sora()
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
