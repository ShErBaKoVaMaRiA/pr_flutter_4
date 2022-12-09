import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cubit_File extends Cubit<HomeState> {
  Cubit_File() : super(const HomeState(0));

  void plus(int c) => emit(HomeState(state.counter + c));
  void minus(int c) => emit(HomeState(state.counter - c));
}

class HomeState {
  final int counter;

  const HomeState(this.counter);
}
