import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pomodoro_app/models/history_model.dart';
import 'package:sqflite/sqflite.dart';

class HistoryService extends ChangeNotifier {
  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initDb();
    return _db;
  }

  List<HistoryModel> historyList = [];

  Future<List<HistoryModel>> getHistories() async {
    historyList.clear();
    final mapList = await queryAllHistory();
    mapList.forEach((element) {
      historyList.add(HistoryModel.fromMap(element));
    });
    notifyListeners();
    return historyList;
  }

  Future<void> deleteAllHistories() async {
    Database? db = await this.db;
    await db!.delete('histories');
    historyList.clear();
    notifyListeners();
  }

  Future<Database?> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = path.join(dir.path, "history.db");
    final historyDb =
        await openDatabase(dbPath, version: 1, onCreate: _createDb);
    return historyDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE histories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        timer TEXT,
        dateTime TEXT,
        isFinish INT
      )
    ''');
  }

  Future<int> addHistory(HistoryModel historyModel) async {
    Database? db = await this.db;
    await db!.insert("histories", historyModel.toMap());
    historyList.add(historyModel);
    notifyListeners();
    return 0;
  }

  Future<List<Map<String, dynamic>>> queryAllHistory() async {
    Database? db = await this.db;
    return await db!.query('histories');
  }
}
