
import 'dart:io';
void main(List<String> arguments) 
{
  /*Chiedere all’utente di scegliere un tipo di esercizio.
    Chiedere all’utente per quanto tempo intende allenarsi (in minuti).
    Calcolare quante calorie vengono bruciate durante l’esercizio, utilizzando i seguenti valori medi (calorie per minuto):
    Corsa: 10 calorie/minuto
    Nuoto: 8 calorie/minuto
    Ciclismo: 6 calorie/minuto
    Sollevamento pesi: 5 calorie/minuto
    Restituire all’utente il totale delle calorie bruciate, inclusi i 
    dettagli dell’esercizio scelto e la durata.*/

  List<String> esercizi = ["gym workout", "swimming", "running","basketball","boxing"];

  print("Inserire quale esercizio svolgere tra questi:  $esercizi");
  String? input = stdin.readLineSync();

  for (var element in esercizi) {
      if(element != input) {print("Errore, chiusura...");  exit(1);  }
    }

  print("Quanti minuti allenarsi? ");
  var minuti = int.parse( stdin.readLineSync()!);

  int? calories;
  switch (input) {
    case "gym workout":
       calories = minuti * 5;
      break;
    case "swimming":
       calories = minuti * 8;
      break;
    case "running":
       calories = minuti * 7;
      break;
    case "basketball":
       calories = minuti * 25;
      break;
    case "boxing":
       calories = minuti * 15;
      break;
    default:
  }
    print("Calories consumate: $calories");


}