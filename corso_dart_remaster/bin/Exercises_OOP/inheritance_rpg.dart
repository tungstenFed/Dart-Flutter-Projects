
import 'dart:io';

bool onePlr = true;
bool isPlrCreated = false;
List<Player> playerList = [];
List<Ability> abilityList = [];
void main(List<String> arguments)
{
  int option;
  bool continua = true;
  while(continua)
  {
    print("\n--- Menu ---");
    print("1- Create Player");
    print("2- Add abilities...");
    print("3- Use abilities");
    print("4- Upgrade abilities");
    print("0- Exit");
    print("Choose an option: ");
    option = int.parse(stdin.readLineSync()!);

    
    switch (option) 
    {
      case 1:
        if(onePlr == true)
        {
          print("Player name: ");
          String plrName = stdin.readLineSync()!;
          Player player = Player(plrName, 1);
          playerList.add(player);

          isPlrCreated = true; onePlr = false;
        } else { print("Player Already Exists. Try Other Action."); }
        break;
      
      case 2:
        print("Choose the ability type [Offensive - 1 | Defensive - 2 | Utility - 3]: ");
        int abilityType = int.parse(stdin.readLineSync()!);

        switch (abilityType)
        {
          case 1:
            print("Choose a name:");
            String name = stdin.readLineSync()!;
            print("Choose a cooldown(s):");
            int cooldown = int.parse(stdin.readLineSync()!);
            print("Choose a damage value:");
            int damage = int.parse(stdin.readLineSync()!);

            OffensiveAbility ability = OffensiveAbility(name, cooldown, damage);
            print("You created: $name with $cooldown second/s cooldown that deals $damage damage.");
            
            playerList[0].listaAbility.add(ability);  abilityList.add(ability);
            break;
          
          case 2:
            print("Choose a name:");
            String name = stdin.readLineSync()!;
            print("Choose a cooldown(s):");
            int cooldown = int.parse(stdin.readLineSync()!);
            print("Choose a shield increase value:");
            int shield = int.parse(stdin.readLineSync()!);

            DefensiveAbility ability = DefensiveAbility(name, cooldown, shield);
            print("You created: $name with $cooldown second/s cooldown that restores $shield shield points.");

            playerList[0].listaAbility.add(ability);  abilityList.add(ability);
            break;
          
          case 3:
            print("Choose a name:");
            String name = stdin.readLineSync()!;
            print("Choose a cooldown(s):");
            int cooldown = int.parse(stdin.readLineSync()!);
            print("Choose a effect duration value:");
            int effDur = int.parse(stdin.readLineSync()!);

            UlityAbility ability =  UlityAbility(name, cooldown, effDur);
            print("You created: $name with $cooldown second/s cooldown that lasts $effDur seconds.");

            playerList[0].listaAbility.add(ability);  abilityList.add(ability);
            break;
        
          default:
            print("Error. Invalid ability type.");
        }
      
      case 3: //player uses ability
      if(abilityList.isEmpty)
      {
        print("Error, no abilities created.");  break;
      }
        print("Which ability? ");
        print("Abilities:");
        for(int i = 0; i<abilityList.length; i++)
        {   print("$i - ${abilityList[i].name}");  }
        int whichAbility = int.parse(stdin.readLineSync()!);


        playerList[0].useAbility(abilityList[whichAbility].name);
        break;
      
      case 4:
        if(abilityList.isEmpty)
        {
        print("Error, no abilities created.");  break;
        }
        print("Which ability? ");
        print("Abilities:");
        for(int i = 0; i<abilityList.length; i++)
        {   print("$i - ${abilityList[i].name}");  }
        int whichAbility = int.parse(stdin.readLineSync()!);


        playerList[0].listaAbility[whichAbility].upgradeAbility();

        break;

      default:
        continua = false;
    }

  }
}

class Player
{
  String name;
  int level;
  List<Ability> listaAbility = [];

  void useAbility(var abilityName)
  {
    print("$name has used $abilityName");
  }

  Player(this.name, this.level);

}

class Ability
{
  String name;
  int cooldown;
  int level = 1;
  
  void upgradeAbility() {level++; print("Upgraded ability $name, current level: $level current x: ");}

  Ability(this.name, this.cooldown);
  
}

class OffensiveAbility extends Ability
{
  int damage;
  OffensiveAbility(String name, int cooldown, this.damage) : super(name,cooldown);

  @override
  void upgradeAbility() {level++; damage += 5; print("Upgraded ability $name, current level: $level | current damage: $damage");}
}

class DefensiveAbility extends Ability
{
  int shield;
  DefensiveAbility(String name, int cooldown, this.shield) : super(name,cooldown);

  @override
  void upgradeAbility() {level++; shield += 10;print("Upgraded ability $name, current level: $level | current shield gain: $shield"); }
}

class UlityAbility extends Ability
{
  int effectDuration;
  UlityAbility(String name, int cooldown, this.effectDuration) : super(name,cooldown);

  @override
  void upgradeAbility() {level++; effectDuration += 2; print("Upgraded ability $name, current level: $level | current duration: $effectDuration");}
}