part of 'get_directions_bloc.dart';

@immutable
abstract class GetDirectionsEvent {}

class GetDirections extends GetDirectionsEvent {
  final String start;
  final String end;
  final String key;

  GetDirections(this.start, this.end, this.key);
}
