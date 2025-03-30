class WeatherModel {
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;
  String weatherIcon;
  String location;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherStateName,
    required this.weatherIcon,
    required this.location,
  });

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    var currentData = data['current'];
    var locationData = data['location'];

    return WeatherModel(
      location: locationData['name'],
      date: DateTime.parse(currentData['last_updated']),
      temp: currentData['temp_c'],
      maxTemp: jsonData['maxtemp_c'],
      minTemp: jsonData['mintemp_c'],
      weatherStateName: jsonData['condition']['text'],
      weatherIcon: "https:${jsonData['condition']['icon']}",
    );
  }

  @override
  String toString() {
    return 'temp = $temp, minTemp = $minTemp, date = $date, icon = $weatherIcon';
  }
}
