import 'package:code/dice_repository.dart';
import 'package:code/play/bloc/play_bloc.dart';
import 'package:code/play/dice_play_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiceApp extends StatefulWidget {
  const DiceApp({super.key});

  @override
  State<DiceApp> createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ),
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PlayBloc(
          repository: context.read<DiceRepository>(),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Dice Football Utility'),
            elevation: 4,
            shadowColor: Theme.of(context).shadowColor,
          ),
          body: const DicePlayView(),
          floatingActionButton: BlocBuilder<PlayBloc, PlayState>(
            builder: (context, state) {
              if (state.status == PlayStatus.playing) {
                return const FloatingActionButton.large(
                  onPressed: null,
                  child: Text(
                    "Select Winner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                );
              }
              return FloatingActionButton.large(
                onPressed: () {
                  context.read<PlayBloc>().add(NewRoundDemandedEvent());
                },
                child: const Text(
                  "New Round",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
