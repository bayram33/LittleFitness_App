import "dart:convert";
import "package:app/data/weather.dart";
import "package:http/http.dart" as http;

class HttpHelper {
  //https://api.openweathermap.org/data/2.5/weather?q=Mersin&units=metric&appid=66e5566f334ab5214dcb11bedc53cfc5
  final String authority = "api.openweathermap.org";
  final String path = "data/2.5/weather";
  final String apiKey = "66e5566f334ab5214dcb11bedc53cfc5";
  final String units = "metric";
  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> paramaters = {
      "q": location,
      "appid": apiKey,
      "units": units,
    };
    Uri uri = Uri.https(authority, path, paramaters);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data = json.decode(result.body);
    Weather weather = Weather.fromJson(data);
    return weather;
  }
}
