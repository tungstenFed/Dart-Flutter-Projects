import 'dart:io';
import 'dart:math';


void main(List<String> arguments)
{
 //classes: Player(PacMan), Items (Coins and PowerUps), Board(Terminal Map), tiles.
    
        Board board = Board(width: 20, height: 11); //put an odd height for a better map
        GameLogic game = GameLogic(board: board); //runs function in his constructor
        game.game();

}

class GameLogic
{
    Board board;
    String currentDirection = "d";
    bool isRunning = true;


    GameLogic({required this.board});
    

    void game() 
    {       
        stdout.write("\x1B[2J\x1B[0;0H"); //clears
        stdin.echoMode = false;
        stdin.lineMode = false; 
        

        stdin.listen((List<int> bytes) {
        if (bytes.isNotEmpty) {
            //reads lists of bytes using the listen function which runs in "background" and keeps waiting for the input
            int lastByte = bytes.last; //gets the last byte of the list meaning the last key pressed
            String key = String.fromCharCode(lastByte).toLowerCase(); //input
            
            if (key == 'q') isRunning = false;
            if ("wasd".contains(key)) { 
            currentDirection = key; //key pressed is the pacman's direction
            }
            if(isRunning == false)
            {
                print("GAME STOPPED");
                exit(0);
            }
        }
        });
            

        loop(); //enters the async loop
    }
    


    void loop() async //runs without stopping other pieces of code like the listen function
    {
        stdout.write("\x1B[2J\x1B[0;0H"); //clears board and puts cursor top left
        print("Score = ${board.score} | q to Exit.");
        board.drawBoard();//keep drawing board
        board.movePacman(currentDirection); //keep moving pacman in that direction

        await Future.delayed(Duration(milliseconds: 300)); //currently dont know about Future objects, but await is only called in asyn function and this line makes it so theres a x ms wait between loops
        if(isRunning == true) //loops only if not stopped
        {loop();}
    }

    

}



class Position
{
    int x;
    int y;

    Position({required this.x, required this.y});
}

class Tile
{
    Position coords;
    bool isWall; //wall or blank space

    void printMe(){
        if(isWall == true)
        {stdout.write("#");}
        else{stdout.write(" ");}
    }

    Tile({required this.coords, required this.isWall});
}

class Pacman extends Tile //they all extend tile so they can be put in the grid which is a list of lists of tiles.
{
    //position from tile
    bool isPacman; //so we know the tile is pacman when drawing it
    @override
    void printMe()
    {
        if(isPacman ==true){stdout.write("C");}
        else{stdout.write(" ");}
    }

    Pacman({required super.coords, required super.isWall, required this.isPacman});
}

class Coins extends Tile
{
    //Position coords; super from tile
    bool isCoin;

    @override
    void printMe()
    {
        if(isCoin ==true){stdout.write(".");}
        else{stdout.write(" ");}
    }

    void collect()
    {
        //Add game Score.
    }

    Coins({required super.coords,required super.isWall, required this.isCoin });
}
class PowerUps extends Tile
{
    //Position coords; super from tile
    bool isPowerUp;

    void collect()
    {
        //power up.
    }

    PowerUps({required super.coords,required super.isWall,required this.isPowerUp });
}
class Board
{
    late Pacman pacman;
    int score = 0;

    int width; int height;
    //Matrice
    List<   List<Tile>  > grid = []; //Rows and columns ( int array[x][y];)
    Random random = Random();
    late bool _isWall;
    void generateGrid()
    {
        for (var i = 0; i < height; i++) 
        {
            List<Tile> row = []; 
            for (var j = 0; j < width; j++) 
            {
                if(i == 0 || i == height-1 || j==0 || j==width-1)   {_isWall = true;}

                else if(i.isEven && i != height-2)
                {
                    if (random.nextInt(10) > 4) {
                       _isWall = true;
                    } 
                    else {
                       _isWall = false;
                    }
                }
                else {_isWall = false;}

                

                //generate items
                if((_isWall == false && i.isOdd) && (j.isEven && j!=0 && j!= width-1 && j!= width-2))
                {
                    row.add(Coins(coords: Position(x: j, y: i), isWall: false, isCoin: true));
                } 
                else if( i==1 && j == 1)
                { 
                    pacman = Pacman(coords: Position(x: j, y: i), isWall: false, isPacman: true);
                    row.add(pacman);
                   
                }
                else 
                {
                    row.add(Tile(coords: Position(x: j, y: i), isWall: _isWall));
                }
            }

            grid.add(row);
        }
    }

    void drawBoard()
    {
        for(var row in grid) {
            for (var tile in row) {
              tile.printMe();
            }
            stdout.write("\n");
        } 
    }

    void movePacman(String? input)
    {
        int dx = 0;
        int dy = 0;
        if(input==null){return;}

        //make code more readable:
        int pacmanX = pacman.coords.x;
        int pacmanY = pacman.coords.y;

        input = input.toLowerCase();

        switch (input) {
            case "d":
                dx = 1;
                break;
            case "a":
                dx =-1;
            break;
            case "w":
                dy = - 1;
            break;
            case "s":
                dy = 1;
            break;
          default:
        }

    int nextX = pacmanX + dx;
    int nextY = pacmanY + dy;

    if(grid[nextY][nextX].isWall == false)
    {
        if(grid[nextY][nextX] is Coins)
        {
            score++;
        }
    
        //clear current position
        grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
        //upd pacman interal coordinations for next iteratin
        pacman.coords.x = nextX;
        pacman.coords.y = nextY;
        //move pacman object
        grid[nextY][nextX] = pacman;

    }

    //     switch (input) {
    //       case "d":

    //         int nextX = pacmanX + 1;
    //         if(grid[pacmanY][nextX] is Coins && grid[pacmanY][nextX].isWall == false)
    //         {
    //             grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
    //             pacman.coords.x += 1; //update pacman's position for next iteration
    //             grid[pacmanY][nextX] = pacman; //update grid and put pacman in his location
    //             score++;
    //         }
    //         else if(grid[pacmanY][nextX].isWall == true)
    //         {}
    //         else if(grid[pacmanY][nextX] is Tile && grid[pacmanY][nextX].isWall == false)
    //         {
    //             grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
    //             pacman.coords.x += 1; 
    //             grid[pacmanY][nextX] = pacman; 
                
    //         }
    //         break;
    //     case "a":

    //         int nextX = pacmanX - 1;

    //         if(grid[pacmanY][nextX] is Coins && grid[pacmanY][nextX].isWall == false)
    //         {
    //             grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
    //             pacman.coords.x -= 1; //update pacman's position for next iteration
    //             grid[pacmanY][nextX] = pacman; //update grid and put pacman in his location
    //             score++;
    //         }
    //         else if(grid[pacmanY][nextX].isWall == true)
    //         {}
    //         else if(grid[pacmanY][nextX] is Tile && grid[pacmanY][nextX].isWall == false)
    //         {
    //             grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
    //             pacman.coords.x -= 1; 
    //             grid[pacmanY][nextX] = pacman; 
    //         }
    //         break;
    //     case "w":   
    //         int nextY = pacmanY - 1;
    //         if(grid[nextY][pacmanX] is Coins && grid[nextY][pacmanX].isWall == false)
    //         {
    //             grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
    //             pacman.coords.y -= 1; //update pacman's position for next iteration
    //             grid[nextY][pacmanX] = pacman; //update grid and put pacman in his location
    //             score++;
    //         }
    //         else if(grid[nextY][pacmanX].isWall == true)
    //         {}
    //         else if(grid[nextY][pacmanX] is Tile && grid[nextY][pacmanX].isWall == false)
    //         {
    //             grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
    //             pacman.coords.y -= 1; 
    //             grid[nextY][pacmanX] = pacman; 
    //         }

    //         break;
    //     case "s":   
    //         int nextY = pacmanY + 1;
    //         if(grid[nextY][pacmanX] is Coins && grid[nextY][pacmanX].isWall == false)
    //         {
    //             grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
    //             pacman.coords.y += 1; //update pacman's position for next iteration
    //             grid[nextY][pacmanX] = pacman; //update grid and put pacman in his location
    //             score++;
    //         }
    //         else if(grid[nextY][pacmanX].isWall == true)
    //         {}
    //         else if(grid[nextY][pacmanX] is Tile && grid[nextY][pacmanX].isWall == false)
    //         {
    //             grid[pacmanY][pacmanX] = Tile(coords: Position(x: pacmanX, y: pacmanY), isWall: false);
    //             pacman.coords.y += 1; 
    //             grid[nextY][pacmanX] = pacman; 
    //         }

    //         break;
    //       default:
    //     }
    }

    Board({required this.width, required this.height})
    {
        generateGrid();
    }

}