import 'package:build_route/core/dio_settings.dart';
import 'package:build_route/features/ui/bloc/get_directions_bloc.dart';
import 'package:build_route/features/ui/data/repositories/get_polyline_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/ui/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DioSettings(),
          ),
          RepositoryProvider(
            create: (context) => GetPolyLineRepo(
                RepositoryProvider.of<DioSettings>(context).dio),
          ),
        ],
        child: BlocProvider<GetDirectionsBloc>(
          create: (context) => GetDirectionsBloc(
            repo: RepositoryProvider.of<GetPolyLineRepo>(context),
          ),
          child: const MainPage(),
        ),
      ),
    );
  }
}
