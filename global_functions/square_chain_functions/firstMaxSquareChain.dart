// import '../../game_classes.dart';
// import '../create_line_checkSq.dart';

// List<Lines> firstMaxSquareChain(List<Lines> totalLines, List<Lines> allLines) {
//   List<Lines> tempAllLines = [];
//   List<Lines> tempRemaining = [];
//   List<Lines> tempFirstChainMoves = [];

//   tempAllLines = List.from(allLines);
//   tempRemaining = List.from(totalLines);

//   void customCheckSquare(List<Lines> tempRemaining) {
//     for (int i = 0; i < tempRemaining.length; i++) {
//       if (checkSquare2(tempRemaining[i], tempAllLines)) {
//         tempAllLines.add(tempRemaining[i]);
//         tempRemaining.remove(tempRemaining[i]);
//         tempFirstChainMoves.add(tempRemaining[i]);
//         customCheckSquare(
//           tempRemaining,
//         );
//       }
//     }
//   }

//   customCheckSquare(tempRemaining);
//   return tempFirstChainMoves;
// }

// bool checkSquare2(Lines line, List<Lines> tempAllLines) {
//   switch (newLine.lineDirection) {
//     case LineDirection.Horiz:

//       //checking for the square below the newLine becuase origin point in in the top left corner and y increases downwards
//       Lines L1 = Lines(
//           firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
//           secondPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord + 1),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Vert); //first vertical line

//       Lines L2 = Lines(
//           firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
//           secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord + 1),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Vert);

//       Lines L3 = Lines(
//           firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord + 1),
//           secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord + 1),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Horiz);

//       if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
//         Square s1 = Square(L1Horiz: newLine, L2Horiz: L3, L1Vert: L1, L2Vert: L2);
//         humanPlayer.addSquares(s1);
//         print('we have detected a sqaure, I repeat. A square below the newLine\n');
//         //in allLines where the line is equal to newLines set its isNew to false
//         allLines.forEach((element) {
//           if (element == newLine) {
//             element.isNew = false;
//           }
//         });

//         humanPlayer.incrementScore();

//         if (GameCanvas.movesLeft == 0) {
//           print('out of moves. Game Over');
//         }
//       }

//       //checking for the square above the newLine becuase origin point in in the top left corner and y increases downwards
//       // print(
//       //     'checking for the square above the newLine becuase origin point in in the top left corner and y increases downwards\n');
//       L1 = Lines(
//           firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
//           secondPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord - 1),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Vert);

//       L2 = Lines(
//           firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
//           secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord - 1),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Vert);

//       L3 = Lines(
//           firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord - 1),
//           secondPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord - 1),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Horiz);

//       // print('l1 containment check: ${allLines.contains(L1)} and l1: $L1');
//       // print('l2 containment check: ${allLines.contains(L2)} and l2: $L2');
//       // print('l3 containment check: ${allLines.contains(L3)} and l3: $L3');  these return true as these should.

//       if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
//         Square s1 = Square(L1Horiz: newLine, L2Horiz: L3, L1Vert: L1, L2Vert: L2);
//         humanPlayer.addSquares(s1);
//         print('we have detected a sqaure, I repeat. a square above the newLine\n');
//       }

//       break;

//     case LineDirection.Vert:

//       //checking for the square on the left side of the newLine in the same manner as above
//       Lines L1 = Lines(
//           firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
//           secondPoint: Points(xCord: newLine.firstPoint.xCord - 1, yCord: newLine.firstPoint.yCord),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Horiz);

//       Lines L2 = Lines(
//           firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
//           secondPoint: Points(xCord: newLine.secondPoint.xCord - 1, yCord: newLine.secondPoint.yCord),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Horiz);

//       Lines L3 = Lines(
//           firstPoint: Points(xCord: newLine.firstPoint.xCord - 1, yCord: newLine.firstPoint.yCord),
//           secondPoint: Points(xCord: newLine.secondPoint.xCord - 1, yCord: newLine.secondPoint.yCord),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Vert);

//       if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
//         Square s1 = Square(L1Horiz: L1, L2Horiz: L2, L1Vert: newLine, L2Vert: L3);
//         humanPlayer.addSquares(s1);
//         print('we have detected a sqaure, I repeat. a square on the left side of the newLine\n');
//       }

//       //After checking for the square above, we are going to check for the square on the right side of 	the newLine in 	the same manner as above

//       L1 = Lines(
//           firstPoint: Points(xCord: newLine.firstPoint.xCord, yCord: newLine.firstPoint.yCord),
//           secondPoint: Points(xCord: newLine.firstPoint.xCord + 1, yCord: newLine.firstPoint.yCord),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Horiz);

//       L2 = Lines(
//           firstPoint: Points(xCord: newLine.secondPoint.xCord, yCord: newLine.secondPoint.yCord),
//           secondPoint: Points(xCord: newLine.secondPoint.xCord + 1, yCord: newLine.secondPoint.yCord),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Horiz);

//       L3 = Lines(
//           firstPoint: Points(xCord: newLine.firstPoint.xCord + 1, yCord: newLine.firstPoint.yCord),
//           secondPoint: Points(xCord: newLine.secondPoint.xCord + 1, yCord: newLine.secondPoint.yCord),
//           owner: humanPlayer,
//           lineDirection: LineDirection.Vert);

//       if (allLines.contains(L1) && allLines.contains(L2) && allLines.contains(L3)) {
//         Square s1 = Square(L1Horiz: L1, L2Horiz: L2, L1Vert: newLine, L2Vert: L3);
//         humanPlayer.addSquares(s1);
//         print('we have detected a sqaure, I repeat. a square on the right side of the newline\n');
//       }

//       break;
//   }
// }
