import 'game_classes.dart';
import 'game_classes/game_canvas.dart';
import 'lists_of_objects.dart';

void main() {
  //we will start by testing the GameCanvas class
  //we will create a new GameCanvas object
  GameCanvas gameCanvas = GameCanvas(level: 1);
  //we will call the levelSwitchCase function
  gameCanvas.levelSwitchCase(2);
  //we will call the createDots function
  print(allPoints.length);

  gameCanvas.calculateMovesLeft();
  // lets see the gameCanvas object. Tests Passed

  //Testing gamePlayers class
  //create a new gamePlayers object isPlayer set to true
  GamePlayers humanPlayer = GamePlayers(isPlayer: true, score: 0, numOfLives: 4, linesDrawn: [], squaresOwned: []);
  humanPlayer.hasTurn = true;
  //create a new gamePlayers object isPlayer set to false for Ai player
  GamePlayers aiPlayer = GamePlayers(isPlayer: false, score: 0, numOfLives: 4, linesDrawn: [], squaresOwned: []);
  aiPlayer.hasTurn = false;
  //tests passed for GamePlayers class

  //Testing the Points class: create two test points
  Points p1 = Points(xCord: 1, yCord: 1);
  Points p2 = Points(xCord: 1, yCord: 1);
  // Points p3 = Points(xCord: 1, yCord: 2);

  //testing the overloaded == operator. lets see the allPoints list contains the above objects or not
  // print(allPoints.contains(p1));
  // print(allPoints.contains(p2));
  // print(p1 == p2);
  // print(p1.hashCode);
  // print(p2.hashCode);

  // //testing the checkDisability function
  // print(Points.checkDisability(p1));
  // //testing the checkNearby function
  // print(Points.checkNearby(p1, p3));

  // //testing the toString method

  // print(p1.toString());
  // print(p1.isUntouched);

  //Testing the Lines class
  Lines l1 = Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Horiz);
  Lines l2 = Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Horiz);
  //lets add the above lines are equal and then we will also add them to the list of the drawn lines and see if they are added or not

  print('see if l1 == l2: ${l1 == l2}');
  print(l1.hashCode);
  print(l2.hashCode);
  humanPlayer.addLines(l1);
  humanPlayer.addLines(l2);
  print(humanPlayer.linesDrawn);

  print(humanPlayer.linesDrawn.contains(l1));
  print(humanPlayer.linesDrawn.contains(l2));
  print(humanPlayer.linesDrawn.length);
  print(humanPlayer.linesDrawn[0].hashCode);
  print(humanPlayer.linesDrawn[1].hashCode);
  print(humanPlayer.linesDrawn[0] == humanPlayer.linesDrawn[1]);
  print(humanPlayer.linesDrawn[0].owner);
  print(humanPlayer.linesDrawn[1].owner);
  print(humanPlayer.linesDrawn[0].owner.hashCode);
  print(humanPlayer.linesDrawn[1].owner.hashCode);
  print(humanPlayer.linesDrawn[0].owner == humanPlayer.linesDrawn[1].owner);
}
