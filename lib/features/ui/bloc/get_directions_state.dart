part of 'get_directions_bloc.dart';

@immutable
abstract class GetDirectionsState {}

class GetDirectionsInitial extends GetDirectionsState {}

class GetDirectionsSucces extends GetDirectionsState {
  final PolyModels model;

  GetDirectionsSucces({required this.model});
}

class GetDirectionsError extends GetDirectionsState {}
