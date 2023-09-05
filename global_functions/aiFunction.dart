//this is the testing stage of the aiFunction

import '../game_classes.dart';
import '../lists_of_objects.dart';
import 'create_line_checkSq.dart';
import 'safeLine_subFunctions/safeline_barrel.dart';
import 'square_chain_functions/firstMaxSquareChain.dart';

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

  print('toatl lines length is ${totalLines.length}');
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
        if (!allLines.contains(totalLines[i])) {
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
  print('safe lines length is ${safeLines.length}');

  /*Now that we have implemented the safe lines list we will use it for several purposes in our game. We are now gonna develop the firstMaxSquareChain function. Following is the full definition of a firstMaxSquareChain():
The firstMaxSquareChain is a series of squares that can be owned by the ai function by drawing a line one after the other and forming a square by each newLine drawn by ai. This is possible will when a user draws an unsafe line which allows the apponent which in this case is aiFunction to consume or own or complete one or more squares in series. Now the question is that how will we find this firstMaxSquareChain. Before we proceed to implement the logic for the firstMaxSquareChain, lets take a look at the definition of a secondMaxSquareChain. A secondMaxSquareChain is also similar to a firstMaxSquareChain but the only difference being that the secondMaxSquareChain has both ends open which mean that although it is not readily awailable to be completed/consumed however it is really dangerous to make a move here because if any player makes a move here. It will cause the entire chain to be available for the apponent. Therefore we have to find this secondMaxSquareChain as well. One more thing, that there may be many secondMaxSquare chains in the game but there can only be one firstMaxSquare chain. We will deal with with this after we are done with the firstMaxSquareCheck. This is why we need to store the secondMaxSquare chains in a list but the firstMaxSquareChain can be calculated and formed on the spot. Following is the flow chart for the firstMaxSquareChain.
•	The first max square chain can be found easily. We just have to find the first line that allows the ai to own a square. Add it to the squares owned and linesdrawn then look again for a line that forms another square and so on. But we will not directly make this move we first have to run this code privately in the ai function and make some calculations and comparisons before doing so. 
•	The firstMaxSquareChain function will contain a copy of allLines list(list of lines drawn in the game) in tempAllLines, tempremainingLines that contains lines of totalLines other than tempAllLines, it will try forEach tempremainingLine where a square may be formed. once we find a line where the square may be formed, we will add  it to the tempSquaresOwned[].
Following pseudo code gives us an idea about the firstSquareMaxChain function:
List<Lines> firstMaxSquareChain() {
	tempAllLines []; //contains a copy of the list of allLines so that we don’t accidently modify the original allLines
	tempRemaining []; //this list contains all the remaining lines. Ie totalLines – allLines;
	//tempSquaresOwned []; //this list will contain the temporary squares formed inside this function. (unnecessary)
	tempFirstChainMoves[]; contains a series of moves to complete squares in chain.
//now we call and define a new function here which well resursively check for squares and add them to tempSquaresOwned[].
	Void customCheckSquare( tempRemaining ) {
		forEach (remainingLine) in tempRemaining {
			if( checkSquare2(remainingLine) ){
				tempAllLines.add(remainingLine);
				tempRemaining.remove(remainingLine);
				tempFirstChainMoves.add(remainingLine);
				customCheckSquare(tempRemaining); //doing recursion
			}
		}
	}
  return tempFirstChainMoves;
} 
//After implementing the firstMaxSquareChain function we will implement the checkSquare2 function. Following is the definition of the checkSquare2 function:
//The checkedSquare2 is a customized version of the checkSquare function that will return true if the square can be formed from the provided line in the argument and returns false otherwise.
 */

  List<Lines> firstChainMoves = [];
  // firstChainMoves = firstMaxSquareChain(totalLines, allLines);
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
