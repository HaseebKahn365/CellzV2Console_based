import '../game_classes.dart';

class Lines {
  Points firstPoint;
  Points secondPoint;
  GamePlayers owner;
  LineDirection lineDirection;
  bool isNew;
  Lines(
      {required this.firstPoint,
      required this.secondPoint,
      required this.owner,
      required this.lineDirection,
      this.isNew = false});
  void animate(Lines providedLine) {
    print('Animating the line: $providedLine');
  }

  @override
  String toString() {
    return 'Line(P1:(${firstPoint.xCord},${firstPoint.yCord}), P2:(${secondPoint.xCord},${secondPoint.yCord}), isPlayer: ${owner.isPlayer}, lineDirection: $lineDirection, isNew: $isNew)';
  }

  @override
  bool operator ==(Object other) {
    if (other is Lines) {
      return this.firstPoint == other.firstPoint && this.secondPoint == other.secondPoint;
    }
    return false;
  }

  //override the hashcodes so that lines with the same first and second points should have the same hashcodes
  @override
  int get hashCode => firstPoint.hashCode ^ secondPoint.hashCode;
}

enum LineDirection { Horiz, Vert }
