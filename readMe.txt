
Points
Members:
Int xCord;
Int yCord;
Bool isMarked; //used to mark the point as bold if already used
Bool isDisabled; //used to avoid selection if point is connected in all four directions
Bool isSelected; //use to mark the point even bolder. When drawing a line
Methods:
Points({required this. xCord, required this. yCord, this. isSelected = false, this. isDisabled = false, this. isSelected = false}); 
Overload the equality operator for Point:
bool operator ==(Point p2){
if(this.xCord == p2.xCord && this.yCord == p2.yCord){return true;} else {return false;}
}
bool checkDisability(Points p1){
    if(p1.isDisabled == true){
        return true;
    }
    //find number of instances of p1 in pointsUsed
    if(
        pointsUsed.where((element) => element.xCord == p1.xCord && element.yCord == p1.yCord).length > 3
    ){
        return true;
    }
    return false;
    
}


Lines
Members:
Points firstPoint;
Points secondPoint;
User owner;
LineDirection lineDirection;

Methods:
Void animate(Lines providedLine){
//animates the provided Line ie. Line drawn by ai function
} 
Void CheckSquare(Lines providedLine){
//this function will check the square based on the line provided as an argument
}
Overload the equality operator for Lines:
bool operator ==(Line l2){
if(this.firstPoint == l2.firstPoint && this.secondPoint == l2.secondPoint){return true;} else {return false;}
}


Enum for directions of the lines drawn
Enum LineDirection = {Horiz, Vert};

Square
Members:
Lines L1Horiz;
Lines L2Horiz;
Lines L1Vert;
Lines L2Vert;

Methods:
Void checkHorizSquare( Lines horizontalLine){
//This function will check if there is a square above or below the current horizontal line which is //provided as an argument.
}
Void checkVertSquare( Lines VerticalLine){
//This function will check if there is a square on the right or left of the current vertical line which is //provided as an argument.
}

GameCanvas
Members:
Int numOfXPoints; // number of points on the x axis.
Int numOfYPoints;// number of points on the y axis.
Static Bool isGameOver; // toCheck if the game is over or not
Static Int movesLeft;

Methods:
Void calculateMovesLeft(int i /*numOfXPoints*/, int j /*numOfYPoints*/ ){
GameCanvas.movesLeft = (i-1)j + (j-1)i;
Void checkVertSquare( Lines VerticalLine){
//This function will check if there is a square on the right or left of the current vertical line which is //provided as an argument.
}


GamePlayers
Members:
Bool isPlayer;
Int score;
Int numOfLives;// 
List<Lines> linesDrawn = [];
List<Squares> squaresOwned = [];
Methods:
Void incrementScore(){
//increments the score as user completes a square/squares
This.score++;
}
Void loseLife(){
//this.life--;
}
Void addSquares(Squares s1){
squaresOwned.add(s1);
}

Development Phase 1 Control Flow:
•	GameStartup:
On the start of the game, we should first create the Points Objects. This task will be carried out by a function called create points which is explained below:
List<Points> allPoints= []; 
List<Points> usedPoints =[]; empty at first

void createPoints(int rows /*numOfXPoints*/, int colums/*numOfYPoints*/){
    for(var i=0; i<rows; i++){
        //creates xCord attributes of points objects
        for(var j=0; j<colums; j++){
            //creates yCord attributes of points objects
            allPoints.add(Point(xCord: i, yCord: j));
        }
    }
}

//After the creation of the points we should plot the Points on the screen from the allPoints[] list based on their respective xCord and yCord Values;
•	Logic for drawing lines:
We should use a gesture detector or any other widget so that when the user pans down on the screen, we will first check if the point is disabled or not. If the Point is disabled then we should not be able to draw a line from this current point. We will check whether the point is diabled or not using the function that we have defined in the Points class. 
bool checkDisability(Points p1){
    if(p1.isDisabled == true){
        return true;
    }
    //find number of instances of p1 in pointsUsed
    if(
        pointsUsed.where((element) => element.xCord == p1.xCord && element.yCord == p1.yCord).length > 3
    ){
        return true;
    }
    return false;
    
}

In case if p1 is not a disabled point, and p1 is being connected with a valid nearby point then add both the points to the usedPoints list.
We should only be able to connect to a nearby point which is only in the nearby zone around the current p1. Ie check using the following function:
bool checkNearby(Points p1, Points p2){
    if(p1.xCord == p2.xCord && p1.yCord == p2.yCord){
        return false;
    }
    if(p1.xCord == p2.xCord && p1.yCord == p2.yCord+1){
        return true;
    }
    if(p1.xCord == p2.xCord && p1.yCord == p2.yCord-1){
        return true;
    }
    if(p1.xCord == p2.xCord+1 && p1.yCord == p2.yCord){
        return true;
    }
    if(p1.xCord == p2.xCord-1 && p1.yCord == p2.yCord){
        return true;
    }
    return false;
}


usedPoints.add(p1);
usedPoints.add(p2);

Determining the direction of the points connected and creating a line object based on the direction and then add it to the list of allLines:
List<Lines> allLines = [];
Lines createLine(Point p1, Point p2){
If((p2.xCord == p1.xCord+1) || (p2.xCord == p1.xCord-1)  ){ 
 return  Lines( firstPoint: p1, secondPoint: p2, lineDirection: LineDirection.Horiz);
}
else if((p2.yCord == p1.yCord+1) || (p2.yCord == p1.yCord-1)  ){ 
 return  Lines( firstPoint: p1, secondPoint: p2, lineDirection: LineDirection.Vert);
}
else{
    return null;
}
}

final newLine = createLine(p1, p2);
allLines.add(newLine);

Now we will come to the cool part where we will check for the squares. We first look for the direction of the line that is passed as an argument to checkSquare() function, after wards we will create 3 new lines and if these newly created 3 lines were found in the List 
We will check for the right and left squares if the line is vertical:
checkSquare(Lines: newLine){
switch(newLine.direction){
case LineDirection.Horiz:
//check for upper and lower square:
//Upper Square:
//L1 is a new line that goes upwards from p1.
Line L1 = Line( Point(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord), Point(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord +1), owner: currentUser, lineDirection: LineDirection.Vert);
//L2 is a new line that goes upwards from p2.
Line L2 = Line( Point(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord), Point(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord +1), owner: currentUser, lineDirection: LineDirection.Vert);
//L3 is a new line that goes above new line in the same direction as newLine.
Line L3 = Line( Point(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord+1), Point(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord+1), owner: currentUser, lineDirection: LineDirection.Horiz);

//check if L1, L2 and L3 are in the list of allLines: then we have a square with owner as current user.

if(allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)){
    //we have a square
    //create a square object and add it to the list of squares owned by the current user.
    Square s1 = Square(L1, L2, L3, newLine);
    currentUser.addSquares(s1);
    //increment the score of the current user.
    currentUser.incrementScore();
    //check if the game is over or not:
    if(GameCanvas.movesLeft == 0){
        //game is over
        //show an alert dialogue box with the title ‘You Won’ and content as the score of the current user and the opponent.
        //show a button to navigate to the home screen.
    }
}

After checking for the square above, we are going to check for the square below the newLine in the same manner as above
//Lower Square:
//L1 is a new line that goes downwards from p1.
L1 = Line( Point(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord), Point(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord -1), owner: currentUser, lineDirection: LineDirection.Vert);
//L2 is a new line that goes downwards from p2.
L2 = Line( Point(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord), Point(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord -1), owner: currentUser, lineDirection: LineDirection.Vert);
//L3 is a new line that goes below new line in the same direction as newLine.
L3 = Line( Point(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord-1), Point(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord-1), owner: currentUser, lineDirection: LineDirection.Horiz);

//check if L1, L2 and L3 are in the list of allLines: then we have a square with owner as current user.

if(allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)){
    //we have a square
    //create a square object and add it to the list of squares owned by the current user.
    Square s1 = Square(L1, L2, L3, newLine);
    currentUser.addSquares(s1);
    //increment the score of the current user.
    currentUser.incrementScore();
    //check if the game is over or not:
    if(GameCanvas.movesLeft == 0){
        //game is over
        //show an alert dialogue box with the title ‘You Won’ and content as the score of the current user and the opponent.
        //show a button to navigate to the home screen.
    }
}

break;

Now its time to check if the line is vertical then we will check the squares on the left and right side of the newLine:
case LineDirection.Vert:
//check for left and right square:
//Left Square:
//L1 is a new line that goes left from p1.
Line L1 = Line( Point(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord), Point(xCord: newLine.firstPoint.xCord-1, yCord: newLine.firstPoint.yCord), owner: currentUser, lineDirection: LineDirection.Horiz);
//L2 is a new line that goes left from p2.
Line L2 = Line( Point(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord), Point(xCord: newLine.secondPoint.xCord-1, yCord: newLine.secondPoint.yCord), owner: currentUser, lineDirection: LineDirection.Horiz);
//L3 is a new line that goes left of new line in the same direction as newLine.
Line L3 = Line( Point(xCord: newLine.firstPoint.xCord-1, yCord: newLine.firstPoint.yCord), Point(xCord: newLine.secondPoint.xCord-1, yCord: newLine.secondPoint.yCord), owner: currentUser, lineDirection: LineDirection.Vert);

//check if L1, L2 and L3 are in the list of allLines: then we have a square with owner as current user.

if(allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)){
    //we have a square
    //create a square object and add it to the list of squares owned by the current user.
    Square s1 = Square(L1, L2, L3, newLine);
    currentUser.addSquares(s1);
    //increment the score of the current user.
    currentUser.incrementScore();
    //check if the game is over or not:
    if(GameCanvas.movesLeft == 0){
        //game is over
        //show an alert dialogue box with the title ‘You Won’ and content as the score of the current user and the opponent.
        //show a button to navigate to the home screen.
    }
}

	After checking for the square above, we are going to check for the square on the right side of 	the newLine in 	the same manner as above
//Right Square:
//L1 is a new line that goes right from p1.
L1 = Line( Point(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord), Point(xCord: newLine.firstPoint.xCord+1, yCord: newLine.firs tPoint.yCord), owner: currentUser, lineDirection: LineDirection.Horiz);
//L2 is a new line that goes right from p2.
L2 = Line( Point(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord), Point(xCord: newLine.secondPoint.xCord+1, yCord: newLine.secondPoint.yCord), owner: currentUser, lineDirection: LineDirection.Horiz);
//L3 is a new line that goes right of new line in the same direction as newLine.
L3 = Line( Point(xCord: newLine.firstPoint.xCord+1, yCord: newLine.firstPoint.yCord), Point(xCord: newLine.secondPoint.xCord+1, yCord: newLine.secondPoint.yCord), owner: currentUser, lineDirection: LineDirection.Vert);

//check if L1, L2 and L3 are in the list of allLines: then we have a square with owner as current user.

if(allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)){
    //we have a square
    //create a square object and add it to the list of squares owned by the current user.
    Square s1 = Square(L1, L2, L3, newLine);
    currentUser.addSquares(s1);
    //increment the score of the current user.
    currentUser.incrementScore();
    //check if the game is over or not:
    if(GameCanvas.movesLeft == 0){
        //game is over
        //show an alert dialogue box with the title ‘You Won’ and content as the score of the current user and the opponent.
        //show a button to navigate to the home screen.
    }
}

break;
}
}

Phases of development:
* Properly overload the == operators, hashcodes and also simplify overridden .toString().
* Test every == operator and method indivisually with proper paramters.
* Test scenario based tests for every method and global functions.
* Integrate a full game loop from start to finish for console based Cellz game.
* Integrate a full game loop from start to finish for GUI based Cellz game.



