enum DiceRoundState { ongoing, team1, team2 }

class DiceRound {
  final int nbPlayersTeam1;
  final int nbPlayersTeam2;
  DiceRoundState status;
  bool isValidated = false;

  DiceRound({
    required this.nbPlayersTeam1,
    required this.nbPlayersTeam2,
    required this.status,
  });
}
