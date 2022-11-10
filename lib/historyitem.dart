class HistoryItem {
  HistoryItem(this.equation, this.result);
  late String equation;
  late String result;

  factory HistoryItem.fromJson(Map<String, dynamic> item) {
    return HistoryItem(item["equation"]!, item["result"]!);
  }

  Map<String, String> toJson() {
    return {
      "equation": equation,
      "result": result
    };
  }
}