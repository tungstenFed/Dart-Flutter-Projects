import 'dart:io';

void funzione1()

{
  int N = int.parse(stdin.readLineSync()!); //! bypasses the null check
  List<int> lista = [];
  bool isDuplicato = false;

  for (var i = 0; i < N; i++) 
  {
      int num = int.parse(stdin.readLineSync()!);

      for (var element in lista) 
      {
        if(num == element)
        {
          isDuplicato = true;
        }
      }

      if(isDuplicato == false)
      {lista.add(num);}
      isDuplicato = false;
      

  }
  double media = 0;
  double somma = 0;
  for (var element in lista)
  {
    somma = somma + element;
  } media = somma / lista.length;

  print("Lista: $lista, Somma: $somma, Media: $media");

}

void funzione2()
{
  int N = int.parse(stdin.readLineSync()!); //! bypasses the null check
  Set<String> sett = {};

  for (var i = 0; i < N; i++) 
  {
      String nome = stdin.readLineSync()!;
      sett.add(nome);
  }
 //[gane,catto,babbo]

  List<String> setAppoggio = sett.toList();
  
  // Bubble sort algorithm to sort the list alphabetically
  for (var i = 0; i < setAppoggio.length - 1; i++) {
    // Outer loop: iterate through each element
    for (var j = i + 1; j < setAppoggio.length; j++) {
      // Inner loop: compare current element with all following elements
      // compareTo returns > 0 if setAppoggio[i] comes after setAppoggio[j] alphabetically
      if(setAppoggio[i].compareTo(setAppoggio[j]) > 0)
      {
        // Swap elements if they are in wrong order
        String temp = setAppoggio[i];
        setAppoggio[i] = setAppoggio[j];
        setAppoggio[j] = temp;
      }
    }
  }

  print(setAppoggio);
}

void funzione3()

{
  int N = int.parse(stdin.readLineSync()!); //! bypasses the null check
  Map<String,int> map = {};
  int punteggioMax = 0;

  for (var i = 0; i < N; i++) 
  {
      String input = stdin.readLineSync()!;
      List<String> inputDiviso= input.split(' ');

      String nome = inputDiviso[0];
      int num = int.parse(inputDiviso[1]);
      
      map[nome] = num;
      if(map[nome]! > punteggioMax)
      {
        punteggioMax = map[nome]!;

      }

      
  }
  double somma = 0; double media = 0;
  map.forEach((key, value) {
    if (value == punteggioMax) {
      print("{$key: $value}");
    }
    somma = somma + value;
  });

  media = somma / map.length;
  print("$somma, $media");
}
void main() {
  //1
  /*L’utente inserisce:
  un numero N
  poi N numeri interi
  Scrivi una funzione che:
  rimuove i duplicati mantenendo l’ordine
  restituisce una nuova lista
  calcola la somma dei numeri che sono maggiori della media*/

  //2
  /*L’utente inserisce:
  un numero N
  poi N parole
  Scrivi una funzione che:
  usa un Set per trovare le parole ripetute
  stampa solo quelle che compaiono più di una volta
  ordinale alfabeticamente*/

  //funzione1();
  //funzione2();

  //3
  //L’utente inserisce:
  // un numero N
  // poi N righe nel formato nome punteggio
  // 
  // Scrivi una funzione che:
  // salva tutto in una Map<String, int>
  // trova il punteggio massimo
  // stampa tutti i nomi che hanno quel punteggio
  // stampa anche il punteggio medio
  funzione3();
}