import '../../game_classes.dart';
import 'firstMaxSquareChain.dart';

secondMaxSquareChain(List<Lines> totalLines, List<Lines> allLines, List<Lines> tempFirstChainMoves) {
  List<List<Lines>> tempSecondMaxChainsList = [];
  List<Lines> tempCheckableLines = [];
  List<Lines> tempAllLines = [];
  tempAllLines = [...allLines, ...tempFirstChainMoves];
  tempCheckableLines = totalLines.where((element) => !tempAllLines.contains(element)).toList();
  // print('tempCheckableLines length is ${tempCheckableLines.length}');
  // print('tempCheckableLines is $tempCheckableLines');
  // print('tempAllLines length is ${tempAllLines.length}');
  // print('tempAllLines is $tempAllLines');
  // print('tempFirstChainMoves length is ${tempFirstChainMoves.length}');
  // print('tempFirstChainMoves is $tempFirstChainMoves');
  // print('totalLines length is ${totalLines.length}');
  // print('totalLines is $totalLines');
  // print('allLines length is ${allLines.length}');
  // print('allLines is $allLines');
  // print('tempSecondMaxChainsList length is ${tempSecondMaxChainsList.length}');
  // print('tempSecondMaxChainsList is $tempSecondMaxChainsList');

  tempCheckableLines.forEach((line) {
    tempAllLines.add(line);
    List<Lines> tempFirstChain = [];
    tempFirstChain = firstMaxSquareChain(totalLines, tempAllLines);
    // print('tempFirstChain length is ${tempFirstChain.length}');
    // print('tempFirstChain is $tempFirstChain');
    if (!tempSecondMaxChainsList.contains(tempFirstChain)) {
      tempSecondMaxChainsList.add(tempFirstChain);
    }
    tempAllLines.remove(line);
  });
  // print('tempSecondMaxChainsList length is ${tempSecondMaxChainsList.length}');
  // print('tempSecondMaxChainsList is $tempSecondMaxChainsList');
  return tempSecondMaxChainsList;
}
