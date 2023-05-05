part of 'play_bloc.dart';

enum PlayStatus { initial, playing, endround }

class PlayState {
  final PlayStatus status;
  final int minPlayers;
  final int maxPlayers;
  int totalTeam1;
  int totalTeam2;
  List<DiceRound> party = [];

  PlayState({
    this.party = const <DiceRound>[],
    this.status = PlayStatus.initial,
    this.minPlayers = 2,
    this.maxPlayers = 10,
    this.totalTeam1 = 0,
    this.totalTeam2 = 0,
  });

  PlayState copyWith({
    PlayStatus? status,
    int? minPlayers,
    int? maxPlayers,
    int? totalTeam1,
    int? totalTeam2,
    List<DiceRound>? party,
  }) {
    return PlayState(
      party: party ?? this.party,
      status: status ?? this.status,
      minPlayers: minPlayers ?? this.minPlayers,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      totalTeam1: totalTeam1 ?? this.totalTeam1,
      totalTeam2: totalTeam2 ?? this.totalTeam2,
    );
  }
}
