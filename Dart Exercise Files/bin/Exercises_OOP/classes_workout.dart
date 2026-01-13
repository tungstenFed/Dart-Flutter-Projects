
// ignore_for_file: non_constant_identifier_names

import 'dart:io';

void main(List<String> arguments)
{
  List<Exercise> ExercisesList = [];
  ExercisesList.add(Exercise(name: "Planche Lean", reps: 8, sets: 4, difficultyLevel: "Medium"));
  ExercisesList.add(Exercise(name: "Pushups", reps: 20, sets: 3, difficultyLevel: "Easy"));
  ExercisesList.add( Exercise(name: "Pullups", reps: 20, sets: 3, difficultyLevel: "Hard"));
  ExercisesList.add(Exercise(name: "Front Lever Tuck", reps: 10, sets: 4, difficultyLevel: "Medium"));
  ExercisesList.add(Exercise(name: "SitUps", reps: 10, sets: 3, difficultyLevel: "Easy"));
  ExercisesList.add(Exercise(name: "Squats", reps: 50, sets: 3, difficultyLevel: "Easy"));

  var continua = true;
  var option;

  List<Athlete> athletesList = [];
  while(continua)
  {

    

    print("\n--- Menu ---");
    print("1- Add Athlete");
    print("2- Show Exercises");
    print("3- Create Workout Session");
    print("4- add Exercises in workout sessions");
    print("5 - show workout lists");
    print("6- Exit");
    print("Choose an option: ");
    option = stdin.readLineSync();

    switch (option) {
      case "1": //Add Athlete
        print("Insert Athlete name and weight separated by a comma only. [JohnDoe,60]");
        var name_kg = stdin.readLineSync()!;
        var list = name_kg.split(",");
        athletesList.add(Athlete(name: list[0], kg: double.parse(list[1])));
        
        print("\n");break;

      case "2": //Show Exercises
        ExercisesList.forEach((element) => print("${element.name}, reps:${element.reps}, sets:${element.sets}, diff:${element.difficultyLevel}"));
        
        print("\n");break;

      case "3": //Create Workout Session
        print("Choose athlete: ");
        for(var i = 0; i < athletesList.length; i++)
        {
          print("$i - ${athletesList[i].name}");
        }
        var ATCode = int.parse(stdin.readLineSync()!);

        print("Insert Workout session name");
        var nameWS = stdin.readLineSync()!;

        //creo una sola istanza
        var ws = WorkoutSession(name: nameWS);
        athletesList[ATCode].addWorkoutSession(ws);
        
        print("\n");break;

      case "4": //add Exercises in workout sessions


        print("Choose athlete: ");
        for(var i = 0; i < athletesList.length; i++)
        {
          print("$i - ${athletesList[i].name}");
        }
        var ATCode = int.parse(stdin.readLineSync()!);


        print("Which workout session?");
        for(var i = 0; i < athletesList[ATCode].workoutSessions.length; i++)
        {
          print("$i - ${athletesList[ATCode].workoutSessions[i].name}");
        }
        var WScode = int.parse(stdin.readLineSync()!) ;
        

        print("Choose exercise from LIST");
        for(var i = 0; i < ExercisesList.length; i++)
        {
          print("$i - ${ExercisesList[i].name}, reps:${ExercisesList[i].reps}, sets:${ExercisesList[i].sets}, diff:${ExercisesList[i].difficultyLevel}");
        }
        var Ecode = int.parse(stdin.readLineSync()!);
        
        athletesList[ATCode].workoutSessions[WScode].aggiungiEsercizio(ExercisesList[Ecode]);

        print("\n");break;

      case "5": //show workout lists
        print("Choose athlete: ");
        for(var i = 0; i < athletesList.length; i++)
        {
          print("$i - ${athletesList[i].name}");
        }
        var ATCode = int.parse(stdin.readLineSync()!);

        for(var i = 0; i < athletesList[ATCode].workoutSessions.length; i++)
        {
          print("Name: ${athletesList[ATCode].workoutSessions[i].name}");

            for(var element in athletesList[ATCode].workoutSessions[i].listaEsercizi)
            {
              print("---Exercises: ${element.name}");
            }
        }

        print("\n"); break;

      case "6":
      print("EXIT...");
        continua = false;
        break;

      }

    
  }


}

class Exercise
{
  String name;
  double reps;
  double sets;
  String difficultyLevel;

  Exercise({required String this.name, required double this.reps, required double this.sets, required String this.difficultyLevel});

  double calcolaVolume() => (reps * sets); //return volume

}

class WorkoutSession //gets exercises
{
  String name;
  List<Exercise> listaEsercizi = [];

  WorkoutSession({required String this.name});

  void aggiungiEsercizio(Exercise esercizio)
  {
    listaEsercizi.add(esercizio);
  }

  void volumeTotale()
  {
    double totVolume = 0.0;
    for (var es in listaEsercizi) 
    {
      totVolume = totVolume + es.calcolaVolume();
    }
    print("Total workout sesh volume: $totVolume");
  }

  void workoutLevel()
  {
    double totVolume = 0.0;
    for (var es in listaEsercizi) 
    {
      totVolume = totVolume + es.calcolaVolume();
    }
    if (totVolume <= 100) 
    {
      print("LIGHT");
    } 
    else if(totVolume >= 100)
    {
      print("HARD");
    }
    else if(totVolume>200)
    {
      print("EXTREME");
    }
  }


}

class Athlete //gets workouts
{
  String name;
  double kg;
  List<WorkoutSession> workoutSessions = [];

  Athlete({required this.name, required this.kg});

  void addWorkoutSession(WorkoutSession workoutSesh)
  {
    this.workoutSessions.add(workoutSesh);
  }

  

}