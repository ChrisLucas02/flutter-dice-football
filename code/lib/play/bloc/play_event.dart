part of 'play_bloc.dart';

abstract class PlayEvent {}

class NewRoundDemandedEvent extends PlayEvent {
  NewRoundDemandedEvent();
}

class NewMinPlayerEvent extends PlayEvent {
  final int minPlayers;
  NewMinPlayerEvent({required this.minPlayers});
}

class NewMaxPlayerEvent extends PlayEvent {
  final int maxPlayers;
  NewMaxPlayerEvent({required this.maxPlayers});
}

class EndRoundDemandedEvent extends PlayEvent {
  final DiceRoundState state;
  EndRoundDemandedEvent({required this.state});
}
