import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodoro_app/models/history_model.dart';
import 'package:pomodoro_app/services/history_service.dart';
import 'package:pomodoro_app/view/widgets/history_widget.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _fetchHistory();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fetchHistory() async {
    await Provider.of<HistoryService>(context, listen: false).getHistories();
  }

  void _deleteAllHistories() async {
    await Provider.of<HistoryService>(context, listen: false)
        .deleteAllHistories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("153448"),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _deleteAllHistories, icon: Icon(Icons.replay))
        ],
        backgroundColor: HexColor("153448"),
        title: Text("History"),
      ),
      body: Consumer<HistoryService>(
        builder: (context, historyService, child) {
          if (historyService.historyList.isEmpty) {
            return Center(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Lottie.asset(
                  "lib/assets/animations/empty_animation.json",
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: historyService.historyList.length,
              itemBuilder: (context, index) {
                HistoryModel historyModel = historyService
                    .historyList[historyService.historyList.length - 1 - index];
                return HistoryWidget(
                  historyModel: historyModel,
                );
              },
            );
          }
        },
      ),
    );
  }
}
