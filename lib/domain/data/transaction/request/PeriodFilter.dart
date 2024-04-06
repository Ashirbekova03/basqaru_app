class PeriodFilter {
  int from;
  int to;

  PeriodFilter({
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toJson() {
    return {
      "from": from,
      "to": to,
    };
  }
}