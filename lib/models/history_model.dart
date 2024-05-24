class HistoryModel {
  int? id;
  String? category;
  String? timer;
  String? dateTime;
  bool? isFinish;
  HistoryModel({
     this.id,
    required this.isFinish,
    required this.category,
    required this.timer,
    required this.dateTime,
  });
  static final aa = [
    HistoryModel(
        category: "category",
        timer: "date",
        dateTime: "date",
        isFinish: false),
    HistoryModel(
        category: "category",
        timer: "date",
        dateTime: "date",
        isFinish: true),
  ];

 Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'timer': timer,
      'dateTime': dateTime,
      'isFinish': isFinish == true ? 1 : 0,
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'],
      category: map['category'],
      timer: map['timer'],
      dateTime: map['dateTime'],
      isFinish: map['isFinish'] == 1,
    );
  }
}
