//this is the testing stage of the aiFunction

import '../game_classes.dart';
import '../lists_of_objects.dart';
import 'create_line_checkSq.dart';
import 'safeLine_subFunctions/safeline_barrel.dart';

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
        if (!safeLines.contains(totalLines[i]) && !allLines.contains(totalLines[i])) {
          safeLines.add(totalLines[i]);
        }
      }
    }
  }

  //lets dig through the entire possible vertical lines and find the safe line

  for (int i = 0; i < totalLines.length; i++) {
    if (totalLines[i].lineDirection == LineDirection.Vert) {
      if (isSafeLine(totalLines[i])) {
        if (!safeLines.contains(totalLines[i]) && !allLines.contains(totalLines[i])) {
          safeLines.add(totalLines[i]);
        }
      }
    }
  }

  //Implementing the isSafeLine function. This function will return true if the line is safe and false if it is not safe
  //Now lets test safe lines. we should get all the lines in the safeLines list as there are in the
  print(safeLines.length);
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

  if (isSafeFirstTwo && isSafeSecondTwo && isSafeFirstEight && isSafeSecondEight) {
    return true;
  } else {
    return false;
  }
}
