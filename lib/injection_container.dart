import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_engineer_assignment/core/constants/network/network_constants.dart';
import 'services/api_service.dart';
import 'blocs/image/image_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  /// externals
  getIt.registerLazySingleton(
    () => Dio()..options = BaseOptions(baseUrl: NetworkConstants.baseUrl),
  );

  /// Services
  getIt.registerLazySingleton(() => ApiService(dio: getIt()));

  /// Blocs
  getIt.registerFactory(() => ImageBloc(getIt()));
}
