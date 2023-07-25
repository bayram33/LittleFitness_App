class Weather {
  String? name;
  String? description;
  double? temperature;
  double? feelslike;
  int? pressure;
  int? humidity;

  Weather(
    this.name,
    this.description,
    this.temperature,
    this.feelslike,
    this.pressure,
    this.humidity,
  );

  Weather.fromJson(Map<String, dynamic> weatherMap) {
    name = weatherMap["name"];
    temperature = weatherMap["main"]["temp"];
    feelslike = weatherMap["main"]["eels_like"];
    pressure = weatherMap["main"]["pressure"];
    humidity = weatherMap["main"]["humidity"];
    description = weatherMap["weather"][0]["main"];
  }
}
