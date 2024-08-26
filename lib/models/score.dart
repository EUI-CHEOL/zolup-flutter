class Cardgameresult {
  late int? id;
  late int? score;
  late String date;

  Cardgameresult({this.id, required this.score, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'date': date,
    };
  }

  Cardgameresult.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    score = map?['score'];
    date = map?['date'];
  }
}

class Memorygameresult {}

class Ordergameresult {}
