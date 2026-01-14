import 'package:dio/dio.dart';
import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../shared/data/data_sources/data_holder/data_holder.dart';
import '../../../../shared/data/data_sources/remote/remote_data_source.dart';
import '../../../../shared/data/models/result_model.dart';
import '../../domain/repositories/tiers_repository.dart';


class TiersRepositoryImpl implements TiersRepository {
  const TiersRepositoryImpl(this.dataSource, this.dataHolder);

  final RemoteDataSource dataSource;  /// PostDataSource
  final DataHolder dataHolder;

  ///  [fetchData] method  is responsible
  /// for fetching the data from the remote source and storing it in the DataHolder.
  /// This method also sets the isDataFetched flag to true to indicate that the data
  /// has been successfully fetched and cached. This prevents multiple network requests.

  @override
  Future<Either<Failure<String>, ResultModel>> getResultModel() async {
    try {
      if (!dataHolder.isDataFetched) {
        final result = await dataSource.fetchData();
        dataHolder.setData(result);
      }
      return Success(dataHolder.getResultModel()!);
    } on DioError catch (e) {
      return Error(Failure.network(e.message));
    } catch (_) {
      return const Error(Failure.other());
    }
  }
}
