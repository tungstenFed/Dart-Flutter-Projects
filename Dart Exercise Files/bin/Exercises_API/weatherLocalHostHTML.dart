import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http; 

var globalTemperature = 0.0;
var globalWeather = "";
var globalCity;

Future<void> startServer() async
{
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 10410);
  //uses loopback/localhost ip and a given port to host a server within the device. its able to send and recieve https requests

  print("Server running on ip loopbackipv4, ip ${server.address}, port ${server.port}");//to check

  //awaits for means that dart keeps waiting for an httpRequest with the await without blocking the whole program, the for means
  //that everytime a http request + response goes through, it resets and keeps waiting for another one like a for cycle...

  //the browser sends a http request to localhost like this GET http://localhost10410
  await for (HttpRequest request in server) 
  {
    request.response //. for each
    ..headers.contentType = ContentType.html //answer the browser with an html which will show an actual html page
    ..write('''<!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Weather & Workout Tracker</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }
            
            .container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                padding: 40px;
                max-width: 500px;
                width: 100%;
            }
            
            h1 {
                color: #333;
                margin-bottom: 30px;
                text-align: center;
                font-size: 28px;
            }
            
            .weather-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 20px;
            }
            
            .weather-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                font-size: 16px;
            }
            
            .weather-item:last-child {
                margin-bottom: 0;
            }
            
            .label {
                font-weight: 600;
                opacity: 0.9;
            }
            
            .value {
                font-size: 20px;
                font-weight: bold;
            }
            
            .info-box {
                background: #f0f4ff;
                border-left: 4px solid #667eea;
                padding: 15px;
                border-radius: 8px;
                margin-top: 20px;
                color: #333;
                font-size: 14px;
                line-height: 1.6;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🌤️ Weather Tracker</h1>
            
            <div class="weather-card">
                <div class="weather-item">
                    <span class="label">📍 City:</span>
                    <span class="value" id="city">${globalCity}</span>
                </div>
                
                <div class="weather-item">
                    <span class="label">🌡️ Temperature:</span>
                    <span class="value" id="temp">${globalTemperature}°C</span>
                </div>
                
                <div class="weather-item">
                    <span class="label"> Condition:</span>
                    <span class="value" id="weather">${globalWeather}</span>
                </div>
            </div>
            
            <div class="info-box">
                <strong>💡 Note:</strong> Only this HTML page was made with AI.
                \nEverything else was made manually with AI's teachings.
            </div>
        </div>
    </body>
</html>''');
    
    
    request.response.close();
  }
}

void main(List<String> arguments) async //async to be able to use await for the http request for the api
{

  
  bool isCityOk = false;
  
  String? city;
  var response;
  var running = true;
  while(running)
  {

    
    do 
    {
      print("Welcome to a workout app with integrated weather-tracking api. I'll be able to tell you either workout outdoors or indoors based on your workout goal.");
      print("Please insert your city (\"quit\" to quit):");
      city = stdin.readLineSync();

      String apiKey = "c698ed75b4864dab853406459a02809f";
      globalCity = city.toString();
      String url = "https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(globalCity)}&appid=${apiKey}&units=metric";

      response = await http.get(Uri.parse(url));
      if(response.statusCode == 200)
      {
        isCityOk = true;
      }
      else if(globalCity == "quit")
      {
        print("Quitting...");
        isCityOk = true;
      }
      else
      {
        print("Error code: ${response.statusCode}");continue;
      }
      
    }while(isCityOk == false);
    
    Map<String,dynamic> data = jsonDecode(response.body);
    globalTemperature = data["main"]["temp"];
    globalWeather = data["weather"][0]["main"];



    startServer();
    print("q to quit | r to restart program");
    running = false;

    stdin.listen((data){ //learn more about this
    var input = String.fromCharCodes(data).trim();
    if(input == "q")
    {
      print("quitting...");

    }
    else if(input == "r")
    {
      print("restarting..");
      running = true;
    }

    });
  
  }

  
  
  


}