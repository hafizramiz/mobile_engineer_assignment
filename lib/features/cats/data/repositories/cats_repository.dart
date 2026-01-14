import 'package:dio/dio.dart';

import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../shared/data/data_sources/data_holder/data_holder.dart';
import '../../../../shared/data/data_sources/remote/remote_data_source.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cats_repository.dart';


class CatsRepositoryImpl implements CatsRepository {
  const CatsRepositoryImpl(this.dataSource, this.dataHolder);

  final RemoteDataSource dataSource;
  final DataHolder dataHolder;

  @override
  Future<Either<Failure<String>, List<Cat>>> getCats() async {
    try {
      if (!dataHolder.isDataFetched) {
        final result = await dataSource.fetchData();
        dataHolder.setData(result);
      }
      return Success(dataHolder.getCats()!);
    } on DioError catch (e) {
      return Error(Failure.network(e.message));
    } catch (_) {
      return const Error(Failure.other());
    }
  }
}
