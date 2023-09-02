import '../game_classes.dart';
import '../lists_of_objects.dart';

//create an instance of humanPlayer:
final humanPlayer = GamePlayers(isPlayer: true, score: 0, numOfLives: 4, linesDrawn: [], squaresOwned: []);

//global list of pointsUsed

Lines createLine(Points p1, Points p2) {
  Lines newLine;
  if (p1.xCord == p2.xCord) {
    //check in allPoints where a point matches with p2 and mark that point as selected
    //TODO:set isSelected to false and isMarked to true for the point p1 and p2 if line is valid and not already drawn after the square is checked and formed
    allPoints.forEach((element) {
      if (element == p2) {
        element.isSelected = true;
      }
    });
    //set the newLine's member isNew to true
    newLine =
        Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Vert, isNew: true);
    //add the new line to the list of lines
    allLines.add(newLine);
    //also add the new line to the list of lines drawn by the current user
    humanPlayer.linesDrawn.add(newLine);
  } else if (p1.yCord == p2.yCord) {
    //check in allPoints where a point matches with p2 and mark that point as selected
    allPoints.forEach((element) {
      if (element == p2) {
        element.isSelected = true;
      }
    });
    newLine =
        Lines(firstPoint: p1, secondPoint: p2, owner: humanPlayer, lineDirection: LineDirection.Horiz, isNew: true);
    //add the new line to the list of lines
    allLines.add(newLine);
    //also add the new line to the list of lines drawn by the current user
    humanPlayer.linesDrawn.add(newLine);
  } else {
    throw Exception('Invalid Line');
  }
  return newLine;
}

Lines? newLine;

checkSquare(Lines newLine) {
  allLines.add(newLine);
  switch (newLine.lineDirection) {
    case LineDirection.Horiz:

      //checking for the square below the newLine becuase origin point in in the top left corner and y increases downwards
      Lines L1 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert); //first vertical line

      Lines L2 = Lines(
          firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      Lines L3 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord + 1),
          secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord + 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
        Square s1 = Square(L1Horiz: newLine, L2Horiz: L3, L1Vert: L1, L2Vert: L2);
        humanPlayer.addSquares(s1);
        print('we have detected a sqaure, I repeat. A square below the newLine\n');

        humanPlayer.incrementScore();

        if (GameCanvas.movesLeft == 0) {
          print('out of moves. Game Over');
        }
      }

      L1 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      L2 = Lines(
          firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      L3 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord - 1),
          secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord - 1),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
        Square s1 = Square(L1Horiz: newLine, L2Horiz: L3, L1Vert: L1, L2Vert: L2);
        humanPlayer.addSquares(s1);
        print('we have detected a sqaure, I repeat\n');

        humanPlayer.incrementScore();

        if (GameCanvas.movesLeft == 0) {}
      }

      break;

    case LineDirection.Vert:
      Lines L1 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.firstPoint.xCord - 1, yCord: newLine.firstPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      Lines L2 = Lines(
          firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord - 1, yCord: newLine.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      Lines L3 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord - 1, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord - 1, yCord: newLine.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
        Square s1 = Square(L1Horiz: L1, L2Horiz: L2, L1Vert: newLine, L2Vert: L3);
        humanPlayer.addSquares(s1);
        print('we have detected a sqaure, I repeat. a square \n');

        humanPlayer.incrementScore();

        if (GameCanvas.movesLeft == 0) {}
      }

      //After checking for the square above, we are going to check for the square on the right side of 	the newLine in 	the same manner as above

      L1 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.firstPoint.xCord + 1, yCord: newLine.firstPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      L2 = Lines(
          firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord + 1, yCord: newLine.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);

      L3 = Lines(
          firstPoint: Points(xCord: newLine.firstPoint.xCord + 1, yCord: newLine.firstPoint.yCord),
          secondPoint: Points(xCord: newLine.secondPoint.xCord + 1, yCord: newLine.secondPoint.yCord),
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);

      if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
        Square s1 = Square(L1Horiz: L1, L2Horiz: L2, L1Vert: newLine, L2Vert: L3);
        humanPlayer.addSquares(s1);
        print('we have detected a sqaure, I repeat\n');

        humanPlayer.incrementScore();

        if (GameCanvas.movesLeft == 0) {}
      }

      break;
  }
}

offsetAnalyzer(Offset P1, Offset Q1, Points currentPoint) {
  //first we need to find the difference between the x-coordinate and y-coordinate of the two offsets
  //minimum offset coordinate difference is 120
  //Lets say we have two points P1(x1,y1) and Q1(x2,y2) as two offsets. Then find the difference between x1 and x2 and y1 and y2
  final xDif = (Q1.dx - P1.dx);
  final yDif = (Q1.dy - P1.dy);
  //X-major (Horizontal) line
  if (xDif.abs() > yDif.abs() && xDif.abs() > 120) {
    //the Line could be in the right or left direction:
    //FOR RIGHT LINE:
    if (xDif > 120) {
      newLine = createLine(Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord),
          Points(xCord: currentPoint.xCord + 1, yCord: currentPoint.yCord));
      print('Horizontal Right created: $newLine');
      if (!allLines.contains(newLine)) {
        allLines.add(newLine);
        checkSquare(newLine!);
      }
      //print the list of allLines:
      print('allLines: $allLines');
    }
    //FOR LEFT LINE:
    else if (xDif < -120 && xDif.abs() > 120) {
      newLine = createLine(
        Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord),
        Points(xCord: currentPoint.xCord - 1, yCord: currentPoint.yCord),
      );
      print('Horizontal Left created: $newLine');
      //add the new line to the allLines list if it does not already exists there:
      if (!allLines.contains(newLine)) {
        allLines.add(newLine);
        //checking if square has formed:
        checkSquare(newLine!);
      }
      //print the list of allLines:
      print('allLines: $allLines');
    }
  }
  //Y-major (Vertical) line
  else if (yDif.abs() > xDif.abs() && yDif.abs() > 120) {
    //the Line could be in the up or down direction:
    //FOR Down LINE:
    //we need to be careful here because when we drag from top to bottom the offset.dy increases which means we have to create a newLine under the following conditions:
    if (yDif > 120) {
      newLine = createLine(Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord),
          Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord + 1));
      print('Vertical Down created: $newLine');

      //add the new line to the allLines list if it does not already exists there:
      if (!allLines.contains(newLine)) {
        allLines.add(newLine);
        //checking if square has formed:
        checkSquare(newLine!);
      }
      //print the list of allLines:
      print('allLines: $allLines');
    }
    //FOR UP LINE:
    else if (yDif < -120) {
      newLine = createLine(
        Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord),
        Points(xCord: currentPoint.xCord, yCord: currentPoint.yCord - 1),
      );
      print('Vertical Up created: $newLine');
      //add the new line to the allLines list if it does not already exists there:
      if (!allLines.contains(newLine)) {
        allLines.add(newLine);
        //checking if square has formed:
        checkSquare(newLine!);
      }
      //print the list of allLines:
      print('allLines: $allLines');
    }
  } else {
    //make the selected p1 unselected
    //use the returned false to make the line unselected
    return false;
  }
}

//create a fake offset class that only has the essential components to test the above code:

class Offset {
  final double dx;
  final double dy;

  Offset({required this.dx, required this.dy});
}
