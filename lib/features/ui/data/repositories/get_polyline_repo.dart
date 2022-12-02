import 'package:build_route/features/ui/data/models/poly_models.dart';
import 'package:dio/dio.dart';

class GetPolyLineRepo {
  final Dio dio;

  GetPolyLineRepo(this.dio);

  Future<PolyModels> getDirections(String start, String end, String key) async {
    final result = await dio
        .get('directions/json?origin=$start&destination=$end&key=$key');
    return PolyModels.fromJson(result.data);
  }
}
