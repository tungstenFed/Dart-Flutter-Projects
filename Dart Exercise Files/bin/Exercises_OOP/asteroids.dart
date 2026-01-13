import 'dart:io';
import 'dart:math';

void main(List<String> arguments) 
{
  //classes as always
  //tile(wall,space,projectile,spaceship,enemies), gamelogic

  print("Choose game difficulty: Easy -press 1, Normal -press 2");
  String input = stdin.readLineSync()!;
  Board board = Board(width: 31, height: 8);

  switch (input) {
    case "1": board.difficulty = "easy";  break;
    case "2": board.difficulty = "hard";  break;
    default:  print("Error, insert either 1 or 2.");  exit(0);}

  board.generateGrid();
  board.drawBoard();
  GameLogic game = GameLogic(board: board);
  game.gameStart();

}

class GameLogic 
{
  Board board;
  late String key;
  void gameStart()
  {
    board.drawBoard();
    stdout.write("\x1B[2J\x1B[0;0H");
    stdin.echoMode = false;
    stdin.lineMode = false;
    board.moveEnemies();

    stdin.listen((data)
    {
      var lastKeyPressed = data.last;
      key = String.fromCharCode(lastKeyPressed);
      
      if(key == "q")
      {
        print("QUITTING"); exit(0);
      }
      board.movePlayerLR(key);

      stdout.write("\x1B[2J\x1B[0;0H"); //clears
      board.drawBoard();

    
    });

    
  gameLoop();
  }  

  void gameLoop() async
  {
    
    stdout.write("\x1B[2J\x1B[0;0H"); //clears
    board.drawBoard();
    board.checkPlayerSatus();
    board.checkEnemySatus();
    board.winCheck();
    await Future.delayed(Duration(milliseconds: 300));
    gameLoop();
  }

  GameLogic({required this.board});
}

class Tile //wall or blanks
{
  int x;
  int y;
  bool isWall;
  bool? isFloor; //can be null therefore not required "required" in the constructor

  void printMe()
  {
    if(isWall == true && isFloor == true)
    { stdout.write("-"); }
    else if(isWall == true && isFloor == false)
    { stdout.write("|"); }
    else
    { stdout.write(" "); }
    
  }

  Tile({required this.x, required this.y, required this.isWall, this.isFloor});
}

class Player extends Tile
{
  @override
  void printMe() {
    stdout.write("A");
  }
  Player({required super.x, required super.y, required super.isWall});
}

class Enemy extends Tile
{
  @override
  void printMe() {
    stdout.write("V");
  }
  Enemy({required super.x, required super.y, required super.isWall});
}

class Projectile extends Tile
{

  @override
  void printMe() {
    stdout.write("|");
  }
  

  Projectile({required super.x, required super.y, required super.isWall});
}

class Board 
{
  List< List<Tile> > listaTile = [];
  int width;
  int height;
  int score = 0;
  int enemyNum = 0;
  late String difficulty;
  late Random random = Random();
  late Player player;
  List<Tile> listaEnemy = []; //tile cuz polimorfismo

  void drawBoard()
  {
    for (var element in listaTile) {
      for (var tile in element) {
        tile.printMe();
      }
      stdout.write("\n");
      
    }
    print("SCORE: $score"); print("ENEMIES: $enemyNum");
  }

  void winCheck()
  {
    if(enemyNum == 0)
    {print("YOU WIN");  exit(0);}
  }
  
  void moveEnemies() async
  {
    while(true)
    {
      int randomEnemyIndex1 = random.nextInt(enemyNum); int randomEnemyIndex2 = random.nextInt(enemyNum); 
      int randomEnemyIndex3 = random.nextInt(enemyNum); int randomEnemyIndex4 = random.nextInt(enemyNum);
      
      for (var en in listaEnemy) 
      {
        en.x = en.x + 1;  listaTile[en.y][en.x] = en; //+1; draw
        listaTile[en.y][en.x - 1] = Tile(x: en.x, y: en.y, isWall: false); //clear trail

      } 
      await Future.delayed(Duration(milliseconds: 2000)); enemyShoot(listaEnemy[randomEnemyIndex1]); 

      for (var en in listaEnemy) 
      {
        en.x = en.x - 1;  listaTile[en.y][en.x] = en; //original pos.; draw
        listaTile[en.y][en.x + 1] = Tile(x: en.x, y: en.y, isWall: false); //clear trail
      } 
      await Future.delayed(Duration(milliseconds: 2000)); enemyShoot(listaEnemy[randomEnemyIndex2]);

      for (var en in listaEnemy) 
      {
        en.x = en.x - 1;  listaTile[en.y][en.x] = en; //-1; draw
        listaTile[en.y][en.x + 1] = Tile(x: en.x, y: en.y, isWall: false); //clear trail
      } 
      await Future.delayed(Duration(milliseconds: 2000)); enemyShoot(listaEnemy[randomEnemyIndex3]);

      for (var en in listaEnemy) 
      {
        en.x = en.x + 1;  listaTile[en.y][en.x] = en; //original pos;  draw
        listaTile[en.y][en.x - 1] = Tile(x: en.x, y: en.y, isWall: false); //clear trail
      } 
      await Future.delayed(Duration(milliseconds: 2000)); enemyShoot(listaEnemy[randomEnemyIndex4]);
      
    }
  }

  void enemyShoot(Tile enemy) async //tile cuz polimorfismo
  {
    if(enemy is Enemy) //so that overwritten/defeated enemies dont shoot
    {
      int belowEnemy = enemy.y + 1;
      int currentEnemyX = enemy.x;

      var projectile = Projectile(x: currentEnemyX, y: belowEnemy, isWall: false);

      for (var y = belowEnemy; y < height-1; y++)
      {
        listaTile[y][currentEnemyX] = projectile;
        if(y!=belowEnemy) //if its not the first iteration
        {listaTile[y-1][currentEnemyX] = Tile(x: currentEnemyX, y: y-1, isWall: false);}
        await Future.delayed(Duration(milliseconds: 300));
        if(y == height-2){listaTile[height-2][currentEnemyX] = Tile(x: currentEnemyX, y: y-2, isWall: false);}
      }
    }
  }

  void playerShoot() async //it would be better to move the game logic in game loop, but not doing that in this project. fully aware.
  {
    int abovePlayer = player.y - 1; //goes up
    int currentPlayerX = player.x; //if u just use player.x it will mess everythign up and as projectile goes upwards it will change x
    var projectile = Projectile(x: currentPlayerX, y: abovePlayer, isWall: false); //create


    for (var y = abovePlayer; y > 0; y--)
    {
      listaTile[y][currentPlayerX] = projectile;
      if(y!=abovePlayer) //if its not the first iteration
      {listaTile[y+1][currentPlayerX] = Tile(x: currentPlayerX, y: y+1, isWall: false);} //delete the projectile trail
      await Future.delayed(Duration(milliseconds: 300)); //every 300ms
      if(y==1){listaTile[1][currentPlayerX] = Tile(x: currentPlayerX, y: 1, isWall: false);}

      //each projectile is indepentend in its own for loop
      //now lets check for enemy collision
      if(listaTile[y - 1][currentPlayerX] is Enemy)
      {
        score++; enemyNum--;
      }
      
    }
  }


  void movePlayerLR(String key)
  {
    int dirx = 0;
    int nextDx;

    switch (key) {
      case "a":
        dirx = -1;
        break;
      case "d":
        dirx = 1;
        break;
      case "f":
        playerShoot();
        break;
      default:
    }

    

    nextDx = player.x + dirx;

    if(listaTile[player.y][nextDx].isWall == true)
    {
     // do nun
    }
    else
    {
      //clear last position of player
      listaTile[player.y][player.x] = Tile(x: player.x, y: player.y, isWall: false);
      //update coords
      player.x = nextDx;
      //move player visually
      listaTile[player.y][nextDx] = player;
    }

  }

  void checkPlayerSatus()
  {
    if((listaTile[player.y][player.x] is Projectile))
    {
      print("GAME OVER");
      exit(0); //ask ai why wouldnt this work  or  just code it in each projectile controlling loop, when the next iteration is player coords then game over
    }

  }
  void checkEnemySatus()
  {
    for(var i = 0; i<listaEnemy.length; i++)
    {
      var enemyY = listaEnemy[i].y;   var enemyX = listaEnemy[i].x; 
      if((listaTile[enemyY][enemyX] is Projectile))
      { listaEnemy.removeAt(i); listaEnemy.insert(i, Tile(x: enemyX, y: enemyY, isWall: false));}
    }
  }

  void generateGrid()
  {
    for (var i = 0; i < height; i++)//20
    {
      List<Tile> row = [];
      for (var j = 0; j < width; j++)//10 (temps)
      {
        if (i == 0 || i == height - 1)
        {
          row.add(Tile(x: j, y: i, isWall: true,  isFloor:true));
        } 
        else if (j == 0 || j == width - 1) 
        {
          row.add(Tile(x: j, y: i, isWall: true, isFloor: false));
        }  
        else if((j == ( (width-1) / 2)  ) && (i == height-2))
        {
          var plr = Player(x: j, y: i, isWall: false);
          player = plr;
          row.add(player);
        }

        //first rows
        else if((( i % 2 != 0 && i == 1 ) && j % 5 == 0) && difficulty == "easy") //first row - easy
        {
          var enemy = Enemy(x: j, y: i, isWall: false);
          listaEnemy.add(enemy);
          enemyNum++;
          row.add(enemy);
        }
        else if((( i % 2 != 0 && i == 1 ) && j % 2 == 0) && difficulty == "hard") //first row -hard
        {
          var enemy = Enemy(x: j, y: i, isWall: false);
          listaEnemy.add(enemy);
          enemyNum++;
          row.add(enemy);
        }
        //second rows
        else if((( i % 2 != 0 && i == 3 ) && j % 6 == 0) && difficulty == "easy") //second row - easy
        {
          var enemy = Enemy(x: j, y: i, isWall: false);
          listaEnemy.add(enemy);
          enemyNum++;
          row.add(enemy);
        }
        else if((( i % 2 != 0 && i == 3 ) && j % 3 == 0) && difficulty == "hard") //second row - hard
        {
          var enemy = Enemy(x: j, y: i, isWall: false);
          listaEnemy.add(enemy);
          enemyNum++;
          row.add(enemy);
        }

        else
        {
           row.add(Tile(x: j, y: i, isWall: false));
        }
      }
      listaTile.add(row);  
    }
  }

  Board({required this.width, required this.height});
}
