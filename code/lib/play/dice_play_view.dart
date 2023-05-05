import 'package:code/model/round.dart';
import 'package:code/play/bloc/play_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DicePlayView extends StatefulWidget {
  const DicePlayView({
    super.key,
  });

  @override
  State<DicePlayView> createState() => _DicePlayViewState();
}

class _DicePlayViewState extends State<DicePlayView> {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, state) {
        _minController.text = state.minPlayers.toString();
        _maxController.text = state.maxPlayers.toString();
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Text("Min:"),
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: _minController,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0, right: 16.0),
                      child: Text("Max:"),
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: _maxController,
                        onSubmitted: (value) {
                          context.read<PlayBloc>().add(
                                NewMaxPlayerEvent(
                                  maxPlayers: int.parse(value),
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView(
                    scrollDirection: axisDirectionToAxis(AxisDirection.down),
                    children: [
                      DataTable(
                        showCheckboxColumn: false,
                        columns: const [
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Team 1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            numeric: true,
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Team 2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            numeric: true,
                          ),
                        ],
                        rows: state.party
                            .map((e) {
                              return DataRow(cells: <DataCell>[
                                DataCell(
                                  onTap: e.isValidated
                                      ? null
                                      : () {
                                          context.read<PlayBloc>().add(
                                              EndRoundDemandedEvent(
                                                  state: DiceRoundState.team1));
                                        },
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              e.status == DiceRoundState.team1
                                                  ? Colors.green
                                                  : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 4.0,
                                        ),
                                        child: Text(
                                          e.nbPlayersTeam1.toString(),
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  onTap: e.isValidated
                                      ? null
                                      : () {
                                          context.read<PlayBloc>().add(
                                                EndRoundDemandedEvent(
                                                  state: DiceRoundState.team2,
                                                ),
                                              );
                                        },
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              e.status == DiceRoundState.team2
                                                  ? Colors.green
                                                  : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 4.0,
                                        ),
                                        child: Text(
                                          e.nbPlayersTeam2.toString(),
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]);
                            })
                            .toList()
                            .reversed
                            .toList(),
                      ),
                    ]),
              ),
              Expanded(
                  child: Column(
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 28),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        state.totalTeam1.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      )),
                      Expanded(
                          child: Text(
                        state.totalTeam2.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      )),
                    ],
                  ),
                  const Divider(),
                ],
              )),
            ],
          ),
        );
      },
    );
  }
}
