import 'package:code/dice_repository.dart';
import 'package:code/model/round.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  final DiceRepository _repository;

  PlayBloc({required DiceRepository repository})
      : _repository = repository,
        super(PlayState()) {
    on<NewMaxPlayerEvent>(
      (event, emit) {
        emit(state.copyWith(maxPlayers: event.maxPlayers));
      },
    );
    on<NewRoundDemandedEvent>((event, emit) {
      final nbPlayersTeam1 = _repository.generateNbPlayer(
        state.minPlayers,
        state.maxPlayers,
      );
      final nbPlayersTeam2 = _repository.generateNbPlayer(
        state.minPlayers,
        state.maxPlayers,
      );
      if (state.party.isNotEmpty) {
        state.party.last.isValidated = true;
        if (state.party.last.status == DiceRoundState.team1) state.totalTeam1++;
        if (state.party.last.status == DiceRoundState.team2) state.totalTeam2++;
      }
      emit(
        state.copyWith(
          status: PlayStatus.playing,
          party: List.of(state.party)
            ..add(
              DiceRound(
                nbPlayersTeam1: nbPlayersTeam1,
                nbPlayersTeam2: nbPlayersTeam2,
                status: DiceRoundState.ongoing,
              ),
            ),
        ),
      );
    });
    on<EndRoundDemandedEvent>(
      (event, emit) {
        state.party.last.status = event.state;
        emit(state.copyWith(
          status: PlayStatus.endround,
          party: List.of(state.party),
        ));
      },
    );
  }
}
