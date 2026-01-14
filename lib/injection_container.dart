import 'package:cat_app_toy_project/core/constants/network/network_constants.dart';
import 'package:cat_app_toy_project/features/cats/presentation/blocs/cats/cats_cubit.dart';
import 'package:cat_app_toy_project/shared/data/data_sources/data_holder/data_holder.dart';
import 'package:cat_app_toy_project/shared/data/data_sources/remote/remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'features/cats/data/repositories/cats_repository.dart';
import 'features/cats/domain/repositories/cats_repository.dart';
import 'features/cats/domain/use_cases/fetch_cats.dart';
import 'features/tiers/data/repositories/tiers_repository.dart';
import 'features/tiers/domain/repositories/tiers_repository.dart';
import 'features/tiers/domain/use_cases/fetch_result_models.dart';
import 'features/tiers/presentation/blocs/tiers/tiers_cubit.dart';


final getIt = GetIt.instance;

Future<void> init() async {
  /// externals
  getIt.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        baseUrl: NetworkConstants.baseUrl,
      ),
  );


  ///remote data sources
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<DataHolder>(
        () => DataHolderImpl(),
  );

  /// Repositories
  getIt.registerLazySingleton<CatsRepository>(
    () => CatsRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton<TiersRepository>(
        () => TiersRepositoryImpl(getIt(), getIt()),
  );
  /// Use cases

  getIt.registerLazySingleton(() => FetchCats(getIt()));
  getIt.registerLazySingleton(() => FetchResultModel(getIt()));

  /// blocs
  getIt.registerFactory(() => CatsCubit(getIt()));
  getIt.registerFactory(() => TiersCubit(getIt()));

}
