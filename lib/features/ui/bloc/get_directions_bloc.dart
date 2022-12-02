import 'package:bloc/bloc.dart';
import 'package:build_route/features/ui/data/models/poly_models.dart';
import 'package:build_route/features/ui/data/repositories/get_polyline_repo.dart';
import 'package:meta/meta.dart';

part 'get_directions_event.dart';
part 'get_directions_state.dart';

class GetDirectionsBloc extends Bloc<GetDirectionsEvent, GetDirectionsState> {
  GetDirectionsBloc({required this.repo}) : super(GetDirectionsInitial()) {
    on<GetDirections>((event, emit) async {
      try {
        final result =
            await repo.getDirections(event.start, event.end, event.key);
        emit(GetDirectionsSucces(model: result));
      } catch (e) {
        emit(GetDirectionsError());
      }
    });
  }
  late final GetPolyLineRepo repo;
}
