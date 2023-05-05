import 'dart:math';

class DiceRepository {
  final Random rnd = Random();

  int generateNbPlayer(int minPlayers, int maxPlayers) {
    return minPlayers + rnd.nextInt(maxPlayers - minPlayers + 1);
  }
}
