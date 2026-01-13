
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http; 


void main(List<String> Arguments) async //async to be able to use await for the http request
{
  print("Simple Weather App!");
  print("Date and Time of your timezone: ${DateTime.now().toLocal()}"); //Date/time of now and .toLocal() = to local timezone.

  print("Insert city name:");
  String? cityName = stdin.readLineSync();
  if(cityName == null){print("Error");  exit(1);}

  String apiKey = "c698ed75b4864dab853406459a02809f"; //api key openweathermap.org
  String url = "https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(cityName)}&appid=${apiKey}&units=metric"; //build the url. encodecomponent avoids https errorrs (New York -> New%20York), url format
  //available on openweathermap.org, current weather api.
  
  var response = await http.get(Uri.parse(url)); //http request, api key converted as uri object(necessary for http.get()), await not to block the program and let the request go thorugh(needs time).
  //responde is an JSON object, because the https returns data as a JSON obj. Therefore it has 2 values, responde.statusCode to check if the request went well
  //and responde.body which is data itself.
  
  //check if responde went through successfully
  if(response.statusCode == 200)
  {
    var decodedData = json.decode(response.body); //decode json in a dart Map<String, Dynamic> because json and maps are very similar (key:value).
    var temperature = decodedData["main"]["temp"];
    var weather = decodedData["weather"][0]["main"]; //either rain or sunny...ù
    var weatherDescription = decodedData["weather"][0]["description"];
    var humidity = decodedData["main"]["humidity"];
    var country = decodedData["sys"]["country"];
    
    print("Country: ${country},\nTemperature: ${temperature},\nWeather: ${weather},\nDescription: ${weatherDescription},\nHumidity: ${humidity}");

  }
  else{
    print("Error handling Http request."); exit(1);
  }

}