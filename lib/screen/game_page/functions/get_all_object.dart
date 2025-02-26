import 'package:popgame/core/settings/enums.dart';
import 'package:popgame/screen/game_page/constant/constants.dart';

List<String> getAllObject(GameModes gameMode) {
  switch (gameMode) {
    case GameModes.alphabet:
      return AlphabetConstants().enAlphabetList;
    case GameModes.number:
      return NumberConstants().numberList20;

    default:
      return [];
  }
}
