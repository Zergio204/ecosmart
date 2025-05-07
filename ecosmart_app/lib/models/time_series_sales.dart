class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);

  // Convertir JSON a objeto
  factory TimeSeriesSales.fromJson(Map<String, dynamic> json) {
    return TimeSeriesSales(
      DateTime.parse(json['time']),
      json['sales'],
    );
  }
}