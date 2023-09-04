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

// To make sure that the newline is safe. We need to consider 20 different unsafe scenarios and make sure that none of these scenarios occur so that we can find a safe line. 4 of these scenarios are a bit different from the other 16. Following are the scenarios:
// 2•	if there are two vertical lines already drawn ie. On the right and left of the newLine then the newline drawn above or below these lines is unsafe.
// 2•	if there are two horizontal lines already drawn ie. below and above of the newLine then the newline drawn on the right or left of these lines is unsafe.
// The following 8 scenarios are when the boundaries lines of the big square might be drawn and we are trying to draw a line inside it.
// 2•	if there are two lines ie the LTL and TTL in the allLines then the newline drawn on the right or Bottom is unsafe
// 2•	if there are two lines ie the TTR and RTR in the allLines then the newline drawn on the left or Bottom is unsafe
// 2•	if there are two lines ie the RBR  and BBR in the allLines then the newline drawn on the left or Top is unsafe
// 2•	if there are two lines ie the BBL and LBL in the allLines then the newline drawn on the right or Top is unsafe

// The following 8 scenarios are when inner lines of the big square might be drawn and we are trying to draw a line outside it.
// 2•	if there are two lines ie the BTL and RTL (inner lines) in the allLines then the newline drawn on the left or Top is unsafe //this is the scenario of the TopLeft square of the big square
// 2•	if there are two lines ie the LTR and BTR (inner lines) in the allLines then the newline drawn on the right or Top is unsafe //this is the scenario of the TopRight square of the big square
// 2•	if there are two lines ie the TBR and LBR (inner lines) in the allLines then the newline drawn on the left or Bottom is unsafe //this is the scenario of the BottomRight square of the big square
// 2•	if there are two lines ie the RBL and TBL (inner lines) in the allLines then the newline drawn on the right or Bottom is unsafe //this is the scenario of the BottomLeft square of the big square

// so in total the above 20 scenarios are the unsafe scenarios and we need to make sure that none of these scenarios occur when we are trying to find a safe line. If any of these scenarios occur then we need to find another safe line. If none of these scenarios occur then we can say that the line is safe to draw.
//list of first four scenarios ie. the two parallel vertical lines and two parallel horizontal lines will be checked in the following code

  bool isSafeFirstTwo = firstTwoScenarios(currentLine);
  bool isSafeSecondTwo = secondTwoScenarios(currentLine);
}

bool firstTwoScenarios(Lines line) {
  //lets say that the point1 is the left point and point2 is the right point.
  //we gotta make sure that there are no vertical lines on the left and right of the currentLine'S left point and right point respectively

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
