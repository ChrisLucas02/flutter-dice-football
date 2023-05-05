import 'package:code/dice_app.dart';
import 'package:code/dice_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(RepositoryProvider.value(
    value: DiceRepository(),
    child: const DiceApp(),
  ));
}
