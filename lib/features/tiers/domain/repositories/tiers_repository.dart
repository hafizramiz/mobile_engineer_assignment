

import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../shared/data/models/result_model.dart';

abstract class TiersRepository {
  Future<Either<Failure<String>, ResultModel>> getResultModel();
}
