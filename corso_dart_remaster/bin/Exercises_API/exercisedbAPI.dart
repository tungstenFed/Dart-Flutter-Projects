// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// void main(List<String> arguments) async {
//   print("Choose equipment to see all related exercises:");
//   String? equipmentName = stdin.readLineSync();
//   if (equipmentName == null) {
//     exit(1);
//   }
  
//   // Try the correct endpoint format
//   var url = "https://oss.exercisedb.dev/api/v1/exercises/pushup";
  
//   print("Trying URL: $url");
//   var response = await http.get(Uri.parse(url));
  
//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body);
    
//     if (data["data"] is List) {
//       print("Found ${data.length} exercises\n");
      
//       for (var exercise in data["data"]) {
//         print("Exercise: ${exercise["name"]}");
//         if (exercise["name"] == "handstand") {
//           print("Success - Found handstand!");
//         }
//       }
//     } else {
//       print("Unexpected response format. Expected a list.");
//     }
//   } else {
//     print("Error: ${response.statusCode}");
//     print("Response: ${response.body}");
//   }
// }

//WORK IN PROGRESS