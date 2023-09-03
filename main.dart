import 'game_classes.dart';

import 'global_functions/create_line_checkSq.dart';
import 'lists_of_objects.dart';

void main() {
  //we will start by testing the GameCanvas class
  GameCanvas gameCanvas = GameCanvas(level: 1);
  //we will create a new GameCanvas object
  //we will call the levelSwitchCase function
  gameCanvas.levelSwitchCase(2);
  //we will call the createDots function
  print(allPoints.length);

  gameCanvas.calculateMovesLeft();
  // lets see the gameCanvas object. Tests Passed

  //Testing gamePlayers class
  //create a new gamePlayers object isPlayer set to true

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
  // Lines l1 = Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Horiz);
  // Lines l2 = Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Horiz);
  //lets add the above lines are equal and then we will also add them to the list of the drawn lines and see if they are added or not

  // print('see if l1 == l2: ${l1 == l2}');
  // print(l1.hashCode);
  // print(l2.hashCode);
  // humanPlayer.addLines(l1);
  // humanPlayer.addLines(l2);
  // print(humanPlayer.linesDrawn);

  // print(humanPlayer.linesDrawn.contains(l1));
  // print(humanPlayer.linesDrawn.contains(l2));
  // print(humanPlayer.linesDrawn.length);
  // print(humanPlayer.linesDrawn[0].hashCode);
  // print(humanPlayer.linesDrawn[1].hashCode);
  // print(humanPlayer.linesDrawn[0] == humanPlayer.linesDrawn[1]);
  // print(humanPlayer.linesDrawn[0].owner);
  // print(humanPlayer.linesDrawn[1].owner);
  // print(humanPlayer.linesDrawn[0].owner.hashCode);
  // print(humanPlayer.linesDrawn[1].owner.hashCode);
  // print(humanPlayer.linesDrawn[0].owner == humanPlayer.linesDrawn[1].owner);

  //test for the lines class passed.

  //create proper test lines with l1 as required this.L1Horiz, required this.L2Horiz, required this.L1Vert, required this.L2Vert...
  //we need proper points from which lines are created

  // Lines l1 = Lines(
  //     firstPoint: allPoints[0],
  //     secondPoint: allPoints[1],
  //     owner: humanPlayer,
  //     lineDirection: LineDirection.Horiz,
  //     isNew: true); //this is the first horizontal line
  // Lines l2 = Lines(
  //     firstPoint: allPoints[2],
  //     secondPoint: allPoints[3],
  //     owner: humanPlayer,
  //     lineDirection: LineDirection.Horiz); //this is the second horizontal line
  // Lines l3 = Lines(
  //     firstPoint: allPoints[0],
  //     secondPoint: allPoints[2],
  //     owner: humanPlayer,
  //     lineDirection: LineDirection.Vert); //this is the first vertical line
  // Lines l4 = Lines(
  //     firstPoint: allPoints[1],
  //     secondPoint: allPoints[3],
  //     owner: humanPlayer,
  //     lineDirection: LineDirection.Vert); //this is the second vertical line
  //print the above lines:
  // print(l1);
  // print(l2);
  // print(l3);
  // print(l4);
  // //lets add the above lines to the list of drawn lines
  // allLines.add(l1);
  // allLines.add(l2);
  // allLines.add(l3);
  // allLines.add(l4);
  // // //lets print the allLines list
  // // // print(allLines);
  // // //test the checkSquare function
  // checkSquare(l1);

  // checkSquare(l2);
  // //This should now be able to check the square and add it to the list of squares owned by the player because we just properly
  // //overloaded the == operator for the Lines class

  // checkSquare(l3); //this should check for square on the right side of the square created by l3

  // checkSquare(l4); //this should check for square on the left side of the square created by l4

  // //lets print the squares owned by the player
  // print(humanPlayer.squaresOwned);

  //testing for level 2 in which we got 4Xpoints and 5Ypoints
  // we have 4 colums and 5 rows
  //lets create the lines for the first square in the top left corner

  // Lines l1 = Lines(
  //     firstPoint: allPoints[0],
  //     secondPoint: allPoints[1],
  //     owner: humanPlayer,
  //     lineDirection: LineDirection.Horiz,
  //     isNew: true); //this is the first horizontal line

  // Lines l2 = Lines(
  //     firstPoint: allPoints[4],
  //     secondPoint: allPoints[5],
  //     owner: humanPlayer,
  //     lineDirection: LineDirection.Horiz); //this is the second horizontal line

  // Lines l3 = Lines(
  //     firstPoint: allPoints[0],
  //     secondPoint: allPoints[4],
  //     owner: humanPlayer,
  //     lineDirection: LineDirection.Vert); //this is the first vertical line

  // Lines l4 = Lines(
  //     firstPoint: allPoints[1],
  //     secondPoint: allPoints[5],
  //     owner: humanPlayer,
  //     lineDirection: LineDirection.Vert); //this is the second vertical line

  // //lets add the above lines to the list of drawn lines
  // allLines.add(l1);
  // allLines.add(l2);
  // allLines.add(l3);
  // allLines.add(l4);

  // //lets print the allLines list
  // print(allLines);
  // //test the checkSquare function
  // checkSquare(l1);
  // //lets check the square by passing the points of bottom horizontal line
  // checkSquare(Lines(
  //     firstPoint: allPoints[4],
  //     secondPoint: allPoints[5],
  //     owner: humanPlayer,
  //     lineDirection:
  //         LineDirection.Horiz)); //the indeces work because the points are added in the order of xCord and yCord

  //Tests for the level 2 passed also for the checkSquare function

  //now lets extensively test the offsetAnalyzer function
  //create two offset objects that have majority of the motion difference in the positive x direction

  // Offset offset1 = Offset(dx: 10, dy: 0);
  // Offset offset2 = Offset(
  //     dx: 500,
  //     dy: 0); //minimum difference for linecreation must be greater than 120 as defined in the offsetAnalyzer function
  // //in this case the offsets are for the horizontal line from left to right. passing the above offsets to the offsetAnalyzer function along with the first point of the line
  // //which in this case is the first point of the first square in the top left corner
  // //lets create the first point of the line
  // Points firstPoint = allPoints[0];
  // offsetAnalyzer(offset1, offset2, firstPoint); //test passed

  // //lets create two offset objects that have majority of the motion difference in the negative x direction
  // Offset offset3 = Offset(dx: -10, dy: 0);
  // Offset offset4 = Offset(dx: -500, dy: 0);
  // offsetAnalyzer(offset3, offset4,
  //     firstPoint); //this newLine should not exist because it is out of bounds of the canvas. test failed . ps: test is passed now because i have added the check for the out of bounds lines in the offsetAnalyzer function

// //lets test two offsets that have majority of the motion difference in the positive y direction
//   Offset offset5 = Offset(dx: 0, dy: 10);
//   Offset offset6 = Offset(dx: 0, dy: 500);
//   offsetAnalyzer(offset5, offset6, allPoints[0]); //test passed

//   //lets test two offsets that have majority of the motion difference in the negative y direction

//   Offset offset7 = Offset(dx: 0, dy: -10);
//   Offset offset8 = Offset(dx: 0, dy: -500);
//   offsetAnalyzer(offset7, offset8, allPoints[0]); //test passed

//   //create two more y offsets to test the line creation in the negative y direction

//   Offset offset9 = Offset(dx: 0, dy: -10);
//   Offset offset10 = Offset(dx: 0, dy: -500);
//   offsetAnalyzer(offset9, offset10, allPoints[4]); //test passed

//   //another one similar to above
//   Offset offset11 = Offset(dx: 0, dy: -10);
//   Offset offset12 = Offset(dx: 0, dy: -500);
//   offsetAnalyzer(offset11, offset12, allPoints[5]); //test passed
}
