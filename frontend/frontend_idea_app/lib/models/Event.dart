class Event {
  String date, timestamp, name;

  Event(this.date, this.timestamp, this.name);

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = json['date'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() => {
        "name": "'" + name + "'",
        "date": "'" + date + "'",
        "timestamp": "'" + timestamp + "'"
      };
}
