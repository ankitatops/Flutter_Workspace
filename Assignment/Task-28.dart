
import 'dart:io';

Future fetchWeather()
{
  return Future.delayed(Duration(seconds: 5)).then((_)
  {
    print("Fetching weather data...");
    print("Almost done...");
  });
}

void main() async
{
  print("Starting weather fetch...");

  await fetchWeather();

  print("Weather data loaded successfully");
}
