import 'game_classes/game_canvas.dart';

void main() {
  //we will start by testing the GameCanvas class
  //we will create a new GameCanvas object
  GameCanvas gameCanvas = GameCanvas(level: 1);
  //we will call the levelSwitchCase function
  gameCanvas.levelSwitchCase(1);
  //we will call the createDots function
  GameCanvas.createDots(gameCanvas.numOfXPoints, gameCanvas.numOfYPoints);

  gameCanvas.calculateMovesLeft();
  // lets see the gameCanvas object
  print(gameCanvas);
}
