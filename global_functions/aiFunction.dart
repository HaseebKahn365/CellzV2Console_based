//this is the testing stage of the aiFunction

import '../game_classes.dart';
import '../lists_of_objects.dart';
import 'create_line_checkSq.dart';

void aiFunction() {
  int numberOfXPoints = 4;
  int numberOfYPoints = 5;
//lets create the totalLines list

  List<Lines> totalLines = [];

  for (int i = 0; i < numberOfYPoints; i++) {
    for (int j = 0; j < numberOfXPoints - 1; j++) {
      Lines newLine = Lines(
          firstPoint: allPoints[i * numberOfXPoints + j],
          secondPoint: allPoints[i * numberOfXPoints + j + 1],
          owner: humanPlayer,
          lineDirection: LineDirection.Horiz);
      totalLines.add(newLine);
    }
  }
//now doing the same for the vertical lines

  for (int i = 0; i < numberOfXPoints; i++) {
    for (int j = 0; j < numberOfYPoints - 1; j++) {
      Lines newLine = Lines(
          firstPoint: allPoints[i + j * numberOfXPoints],
          secondPoint: allPoints[i + (j + 1) * numberOfXPoints],
          owner: humanPlayer,
          lineDirection: LineDirection.Vert);
      totalLines.add(newLine);
    }
  }

  print(totalLines.length);
  print(GameCanvas
      .movesLeft); //test passed: the totalLines list is created properly and the length is 31 which is correct. this is becuase we have 4Xpoints and 5Ypoints and the total number of lines is 5*3 + 4*4 = 31
//making sure that all the lines in the totalLines list are correct and valid.

  // for (int i = 0; i < totalLines.length; i++) {
  //   print(totalLines[i]);
  // }

  //creating a nullable list of safeLine Lines objects

  List<Lines?> safeLines = [];

  //implementing the logic to assign a proper safe Lines to the safeLines list
  //we will iterate through all the totalLines then look for the unsafe lines in the allLines and assign all the safe lines to the safeLines list
  //Lets create another function that looks for a safeLine and returns it

//lets dig through the entire possible horizontal lines and find the safe line

  for (int i = 0; i < totalLines.length; i++) {
    if (totalLines[i].lineDirection == LineDirection.Horiz) {
      if (isSafeLine(totalLines[i])) {
        safeLines.add(totalLines[i]);
      }
    }
  }

  //lets dig through the entire possible vertical lines and find the safe line

  for (int i = 0; i < totalLines.length; i++) {
    if (totalLines[i].lineDirection == LineDirection.Vert) {
      if (isSafeLine(totalLines[i])) {
        safeLines.add(totalLines[i]);
      }
    }
  }

  //Implementing the isSafeLine function. This function will return true if the line is safe and false if it is not safe
}

bool isSafeLine(Lines line) {
  Lines currentLine = line;

// so in total the above 20 scenarios are the unsafe scenarios and we need to make sure that none of these scenarios occur when we are trying to find a safe line. If any of these scenarios occur then we need to find another safe line. If none of these scenarios occur then we can say that the line is safe to draw.
//list of first four scenarios ie. the two parallel vertical lines and two parallel horizontal lines will be checked in the following code
//the firstTwoScenarios are testing only if the current line is a horizontal line

  bool isSafeFirstTwo = (currentLine.lineDirection == LineDirection.Horiz) ? firstTwoScenarios(currentLine) : true;
  bool isSafeSecondTwo = (currentLine.lineDirection == LineDirection.Vert) ? secondTwoScenarios(currentLine) : true;

  bool isSafeFirstEight = firstEightScenarios(currentLine);
  bool isSafeSecondEight = secondEightScenarios(currentLine);
}

bool firstTwoScenarios(Lines line) {
  //lets say that the point1 is the left point and point2 is the right point.
  //we gotta make sure that there are no vertical lines on the left and right of the currentLine'S left point and right point respectively

  //

  Points leftPoint = line.firstPoint;
  Points rightPoint = line.secondPoint;

  //vertical line 1 below the left point:
  Lines verticalLine1 = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //vertical line 2 below the right point:
  Lines verticalLine2 = Lines(
      firstPoint: rightPoint,
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //vertical line 3 above the left point:
  Lines verticalLine3 = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //vertical line 4 above the right point:
  Lines verticalLine4 = Lines(
      firstPoint: rightPoint,
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  if (allLines.contains(verticalLine1) && allLines.contains(verticalLine2)) {
    return false;
  }

  if (allLines.contains(verticalLine3) && allLines.contains(verticalLine4)) {
    return false;
  }

//last control statement
  else {
    return true;
  }
}

bool secondTwoScenarios(Lines line) {
  //lets say that the point1 is the upperPoint of the line and point2 is the lowerPoint of the line.
  //we gotta make sure that there are no horizontal lines on the top and bottom of the currentLine'S upperPoint and lowerPoint respectively

  Points upperPoint = line.firstPoint;
  Points lowerPoint = line.secondPoint;

  //horizontal line 1 on the right of the upper point:
  Lines horizontalLine1 = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //horizontal line 2 on the right of the lower point:
  Lines horizontalLine2 = Lines(
      firstPoint: lowerPoint,
      secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //horizontal line 3 on the left of the upper point:
  Lines horizontalLine3 = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //horizontal line 4 on the left of the lower point:
  Lines horizontalLine4 = Lines(
      firstPoint: lowerPoint,
      secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(horizontalLine1) && allLines.contains(horizontalLine2)) {
    return false;
  }

  if (allLines.contains(horizontalLine3) && allLines.contains(horizontalLine4)) {
    return false;
  }

  //last control statement
  else {
    return true;
  }
}

bool firstEightScenarios(Lines line) {
//   The following 8 scenarios are when the boundaries lines of the big square might be drawn and we are trying to draw a line inside it.
// 2•	if there are two lines ie the LTL and TTL in the allLines then the newline drawn on the right or Bottom is unsafe

//let the recieved line be the BTL line then we need to check if the LTL and TTL lines are drawn or not

  Points leftPoint = line.firstPoint;
  Points rightPoint = line.secondPoint;

  //defining LTL from the leftPoint
  //Only check it if the line is horizontal

  Lines LTL;
  Lines TTL;

  if (line.lineDirection == LineDirection.Horiz) {
    Lines LTL = Lines(
        firstPoint: leftPoint,
        secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining TTL from leftPoint and rightPoint
    Lines TTL = Lines(
        firstPoint: leftPoint,
        secondPoint: Points(xCord: leftPoint.xCord - 1, yCord: rightPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(LTL) && allLines.contains(TTL)) {
      return false;
    }
  }

//let the recieved line be the RTL then we need to check again if the LTL and TTL lines are drawn or not

  Points upperPoint = line.firstPoint;
  Points lowerPoint = line.secondPoint;

  //defining LTL from the upperPoint
  //only check it if the line is vertical

  if (line.lineDirection == LineDirection.Vert) {
    LTL = Lines(
        firstPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
        secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Vert);

    //defining TTL from upperPoint and lowerPoint
    TTL = Lines(
        firstPoint: upperPoint,
        secondPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
        owner: humanPlayer,
        lineDirection: LineDirection.Horiz);

    if (allLines.contains(LTL) && allLines.contains(TTL)) {
      return false;
    }
  }

//let the received line be the BTR line then we need to check if the TTR and RTR lines are drawn or not //TODO: check this code

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining TTR from the rightPoint
  Lines TTR = Lines(
      firstPoint: rightPoint,
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining RTR from leftPoint and rightPoint
  Lines RTR = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: rightPoint.xCord + 1, yCord: rightPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(TTR) && allLines.contains(RTR)) {
    return false;
  }

  //let the recieved line be the LTR then we need to check again if the TTR and RTR lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining TTR from the upperPoint
  TTR = Lines(
      firstPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
      secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining RTR from upperPoint and lowerPoint
  RTR = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(TTR) && allLines.contains(RTR)) {
    return false;
  }

//let the received line be the LBR line then we need to check if the RBR and BBR lines are drawn or not //TODO: check this code

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining RBR from the rightPoint
  Lines RBR = Lines(
      firstPoint: rightPoint,
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining BBR from leftPoint and rightPoint
  Lines BBR = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: rightPoint.xCord - 1, yCord: rightPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(RBR) && allLines.contains(BBR)) {
    return false;
  }

  //let the recieved line be the TBR then we need to check again if the RBR and BBR lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining RBR from the lowerPoint
  RBR = Lines(
      firstPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
      secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining BBR from upperPoint and lowerPoint
  BBR = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(RBR) && allLines.contains(BBR)) {
    return false;
  }

  //let the received line be the TBL line then we need to check if the BBL and LBL lines are drawn or not //TODO: check this code

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining BBL from the leftPoint

  Lines BBL = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining LBL from leftPoint and rightPoint
  Lines LBL = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: leftPoint.xCord - 1, yCord: leftPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(BBL) && allLines.contains(LBL)) {
    return false;
  }

  //let the recieved line be the RBL then we need to check again if the BBL and LBL lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining BBL from the lowerPoint
  BBL = Lines(
      firstPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
      secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining LBL from upperPoint and lowerPoint
  LBL = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(BBL) && allLines.contains(LBL)) {
    return false;
  }

  //now we have checked all the 8 scenarios and we can say that the line is safe to draw
  else {
    return true;
  }
}

bool secondEightScenarios(Lines line) {
//   The following 8 scenarios are when inner lines of the big square might be drawn and we are trying to draw a line on the border.

// 2•	if there are two lines ie the BTL and RTL (inner lines) in the allLines then the newline drawn on the left or Top is unsafe //this is the scenario of the TopLeft square of the big square

//let the recieved line be the LTL line then we need to check if the BTL and RTL lines are drawn or not

  Points upperPoint = line.firstPoint;
  Points lowerPoint = line.secondPoint;

//defining BTL from the lowerPoint

  Lines BTL = Lines(
      firstPoint: lowerPoint,
      secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

//defining RTL from upperPoint and lowerPoint

  Lines RTL = Lines(
      firstPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
      secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  if (allLines.contains(BTL) && allLines.contains(RTL)) {
    return false;
  }

//let the recieved line be the TTL then we need to check again if the BTL and RTL lines are drawn or not

  Points leftPoint = line.firstPoint;
  Points rightPoint = line.secondPoint;

//defining RTL from the rightPoint

  RTL = Lines(
      firstPoint: rightPoint,
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

//defining BTL from leftPoint and rightPoint

  BTL = Lines(
      firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
      secondPoint: Points(xCord: rightPoint.xCord - 1, yCord: rightPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(BTL) && allLines.contains(RTL)) {
    return false;
  }

  //let the received line be the TTR line then we need to check if the LTR and BTR lines are drawn or not //TODO: check this code

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining LTR from the leftPoint
  Lines LTR = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining BTR from leftPoint and rightPoint

  Lines BTR = Lines(
      firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord + 1),
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord + 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(LTR) && allLines.contains(BTR)) {
    return false;
  }

  //let the recieved line be the RTR then we need to check again if the LTR and BTR lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining BTR from the lowerPoint

  BTR = Lines(
      firstPoint: lowerPoint,
      secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //defining LTR from upperPoint and lowerPoint

  LTR = Lines(
      firstPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
      secondPoint: Points(xCord: lowerPoint.xCord - 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  if (allLines.contains(LTR) && allLines.contains(BTR)) {
    return false;
  }

  //let the received line be the RBR line then we need to check if the TBR and LBR lines are drawn or not //TODO: check this code

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining TBR from the upperPoint

  Lines TBR = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord - 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //defining LBR from upperPoint and lowerPoint

  Lines LBR = Lines(
      firstPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
      secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  if (allLines.contains(TBR) && allLines.contains(LBR)) {
    return false;
  }

  //let the recieved line be the BBR then we need to check again if the TBR and LBR lines are drawn or not

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining LBR from the rightPoint

  LBR = Lines(
      firstPoint: leftPoint,
      secondPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining TBR from leftPoint and rightPoint

  TBR = Lines(
      firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(TBR) && allLines.contains(LBR)) {
    return false;
  }

  //let the received line be the BBL line then we need to check if the TBL and RBL lines are drawn or not //TODO: check this code

  leftPoint = line.firstPoint;
  rightPoint = line.secondPoint;

  //defining RBL from the rightPoint

  Lines RBL = Lines(
      firstPoint: rightPoint,
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  //defining TBL from leftPoint and rightPoint

  Lines TBL = Lines(
      firstPoint: Points(xCord: leftPoint.xCord, yCord: leftPoint.yCord - 1),
      secondPoint: Points(xCord: rightPoint.xCord, yCord: rightPoint.yCord - 1),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  if (allLines.contains(TBL) && allLines.contains(RBL)) {
    return false;
  }

  //let the recieved line be the LBL then we need to check again if the TBL and RBL lines are drawn or not

  upperPoint = line.firstPoint;
  lowerPoint = line.secondPoint;

  //defining TBL from the upperPoint

  TBL = Lines(
      firstPoint: upperPoint,
      secondPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Horiz);

  //defining RBL from upperPoint and lowerPoint

  RBL = Lines(
      firstPoint: Points(xCord: upperPoint.xCord + 1, yCord: upperPoint.yCord),
      secondPoint: Points(xCord: lowerPoint.xCord + 1, yCord: lowerPoint.yCord),
      owner: humanPlayer,
      lineDirection: LineDirection.Vert);

  if (allLines.contains(TBL) && allLines.contains(RBL)) {
    return false;
  }

  //now we have checked all the 8 scenarios and we can say that the line is safe to draw
  else {
    return true;
  }
}
