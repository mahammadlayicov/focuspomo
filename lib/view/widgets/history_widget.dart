import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pomodoro_app/models/history_model.dart';
import 'package:pomodoro_app/provider/timer_provider.dart';
import 'package:provider/provider.dart';

class HistoryWidget extends StatelessWidget {
  HistoryModel historyModel;
  HistoryWidget({
    required this.historyModel,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color:
                    historyModel.isFinish! ? Colors.green : HexColor("cd0826"),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            width: 20,
          ),
          Container(
            height: 120,
            width: 120,
            child: historyModel.isFinish!
                ? Image.asset(
                    "lib/assets/images/1.png",
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "lib/assets/images/2.png",
                    fit: BoxFit.cover,
                  ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    maxLines: 1,
                    historyModel.category!,
                    style: GoogleFonts.sora()
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.timer_outlined),
                      Text(
                        maxLines: 2,
                        historyModel.timer!,
                        style: GoogleFonts.sora().copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -10),
                  child: Container(
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey.shade300,
                        ),
                        Row(
                          children: [
                            Text(
                              historyModel.dateTime!,
                              style: GoogleFonts.sora().copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
