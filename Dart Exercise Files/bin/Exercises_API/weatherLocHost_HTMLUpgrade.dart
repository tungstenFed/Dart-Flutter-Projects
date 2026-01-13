import 'dart:io'; 
import 'package:http/http.dart' as http; 


String apiKey = "c698ed75b4864dab853406459a02809f";
String url = "https://maps.openweathermap.org/maps/2.0/weather/1h/TA2/5/16/10?appid=$apiKey";
var response;
//italy weather map by tiles (current)
  

void main(List<String> arguments) async //async to be able to use await for the http request for the api
{
//API CONFIG


    print("Air temperature in italy. Initializing code...");

    serverStart();
    print("insert 'q' to quit");
    stdin.listen((data)
    {
      
      var input = String.fromCharCodes(data).trim();
      if (input == "q") 
      {
        exit(0);
      } 

    });

  }



void serverStart() async
{
  HttpServer localhostserver = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  print("Server ip: ${localhostserver.address}, port: ${localhostserver.port}");
  await for (HttpRequest request in localhostserver) {
    // 🔹 IMAGE ROUTE
    if (request.uri.path == '/tile') {
      final tileResponse = await http.get(Uri.parse(url));

      print("Tile status: ${tileResponse.statusCode}");
      print("Tile content-length: ${tileResponse.bodyBytes.length}");
      print("Tile content-type: ${tileResponse.headers['content-type']}");


      request.response.headers.contentType =
          ContentType('image', 'png');

      request.response.add(tileResponse.bodyBytes);
      await request.response.close();
      continue;
    }

    // 🔹 HTML ROUTE
    request.response.headers.contentType = ContentType.html;
    request.response.write('''
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>Weather Tile</title>
      </head>
      <body style="background:black; display:flex; justify-content:center;">
        <img src="/tile" style="width:800px; height:800px; image-rendering:pixelated;">
      </body>
      </html>
    ''');

    await request.response.close();
  }

}