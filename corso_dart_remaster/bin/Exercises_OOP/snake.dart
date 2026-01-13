import 'dart:io';
import 'dart:math';
void main(List<String> arguments)
{
  //classes: board -> array of : tiles -> items, walls, blanks, snake
  Board board = Board(width: 20, height: 10);
  gameLogic(board: board);
}

class gameLogic
{
  Board board;
  String? key = "d";

  void gameStart()
  {
      stdout.write("\x1B[2J\x1B[0;0H"); //clears
      stdin.echoMode = false;
      stdin.lineMode = false;
    stdin.listen((data)
    {
       
      var lastKeyPressed = data.last;
      key = String.fromCharCode(lastKeyPressed);
      if(key == "q")
      {print("Game Stopped"); exit(0);}

      
    });
    gameLoop();
  }
  
  void gameLoop() async
  {
    stdout.write("\x1B[2J\x1B[0;0H"); //clears
    board.drawGrid();
    board.moveSnake(key);
    await Future.delayed(Duration(milliseconds: 300));

    gameLoop();
  }

  gameLogic({required this.board})
  {gameStart();}
}

class Snake extends Tile
{
  bool isSnake;
  @override
  void printMe() 
  {
    stdout.write("o");
  }

  Snake({required super.x, required super.y, required super.isWall, required this.isSnake});
}

class Board
{
  List< List<Tile> > listaTile = [];
  late List<Snake> snakeList = [];
  late bool isWall;
  late Random random = Random();
  int width;
  int height;
  int score = 0;

  Board({required this.width, required this.height})
  {
    generateGrid();
    drawGrid();
  }

  void generateGrid()
  {
    int startingRandomwidth = random.nextInt(width) + 1;
    int startingRandomheight = random.nextInt(height) + 1; //not 0

    if(startingRandomheight == height)
    {
      startingRandomheight - 1;
    }
    else if(startingRandomwidth == width)
    {
      startingRandomwidth - 1;
    }

    for (var i = 0; i < height; i++) 
    { List<Tile> rowTile = [];
      for (var j = 0; j < width; j++) 
      {
        
        if(i == 0 || i == height - 1 || j == 0 || j == width-1 )
        {
          rowTile.add(Tile(x: width, y: height, isWall: true));
        }
        else if(i==1&&j==1)
        {
          snakeList.add(Snake(x: 1, y: 1, isWall: false, isSnake: true));
          rowTile.add(Snake(x: 1, y: 1, isWall: false, isSnake: true));
        }
        else if(i == startingRandomheight && j == startingRandomwidth)
        {
          rowTile.add(Coins(x: startingRandomwidth, y: startingRandomheight, isWall: false, isCoin: true, isEaten: false));
        }
        else
        {
          rowTile.add(Tile(x: width, y: height, isWall: false));
        }
      }

      listaTile.add(rowTile);
    }
  } 

  void drawGrid()
  {
    for (var element in listaTile) 
    {
      for(var tile in element)
      {
        tile.printMe();
      }
      stdout.write("\n");
    }
  }

  void moveSnake(String? input)
  {
    if(input==null){return;}


    int dir_x = 0;
    int dir_y = 0;

    int snakeX = snakeList[0].x;
    int snakeY = snakeList[0].y;
    
     switch (input) {
            case "d":
                dir_x = 1;
                break;
            case "a":
                dir_x =-1;
            break;
            case "w":
                dir_y = - 1;
            break;
            case "s":
                dir_y = 1;
            break;
          default:
      }
    
    int nextDx = snakeX + dir_x;
    int nextDy = snakeY + dir_y;

    if(listaTile[nextDy][nextDx].isWall == false)
    {
      //remove head trail
      listaTile[snakeY][snakeX] = Tile(x: snakeX, y: snakeY, isWall: false);

      if(listaTile[nextDy][nextDx] is Coins)
      {
        score++;

            var nextSnake = Snake(x: snakeX - 1, y: snakeY , isWall: false, isSnake: true);
            snakeList.add(nextSnake);
            //if coin add a snake (one piece)

            //regenerate random coin place
            int randomWidth = random.nextInt(width) + 1;
            int randomHeight = random.nextInt(height) + 1; //not 0
            listaTile[randomHeight][randomWidth] = Coins(x: randomWidth, y: randomHeight, isWall: false, isCoin: true, isEaten: false);
      }
      
      //clear my position
      //put snake in the next position
      //update snake's coords so that in the next iteration everything's correct
      
      //for every segment 
      for(int i = snakeList.length - 1; i > 0; i--)
      {
        //l'ultimo diventa sempre il prossimo quindi ci sarà sempre un inutile rimasto indietro
        var lastSegment = snakeList.last;

        //the last segment gets cancelled
        //every iteration we remove the useless once left behind by every movement which is the [i]
        listaTile[lastSegment.y][lastSegment.x] = Tile(x: lastSegment.x, y: lastSegment.y, isWall: false);

        //update trail coords to follow head and eventually comes to [0] which is the head yk
        snakeList[i].x = snakeList[i-1].x;
        snakeList[i].y = snakeList[i-1].y;
        
        
        

      }
      //update head
      snakeList[0].x = nextDx; snakeList[0].y = nextDy;
      listaTile[nextDy][nextDx] = snakeList[0];

      for (var snake in snakeList) 
      {
        listaTile[snake.y][snake.x] = snake;
      }

    }

  }

}

class Tile //wall or blanks
{
  int x;
  int y;
  bool isWall;

  void printMe()
  {
    if(isWall == true)
    {
      stdout.write("#");
    }
    else
    {
      stdout.write(" ");
    }
    
  }

  Tile({required this.x, required this.y, required this.isWall});
}

class Coins extends Tile
{
  bool isCoin;
  bool isEaten;

  @override
  void printMe() {
    stdout.write(".");
  }
  

  Coins({required super.x, required super.y, required super.isWall, required this.isCoin, required this.isEaten});
}

