
import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../../shared/data/models/result_model.dart';
import '../repositories/tiers_repository.dart';


class FetchResultModel extends Usecase<String, ResultModel, int?> {
  FetchResultModel(this.tiersRepository);

  final TiersRepository tiersRepository;

  @override
  Future<Either<Failure<String>, ResultModel>> call() {
    final a= tiersRepository.getResultModel();
    print(a);
    return tiersRepository.getResultModel();
  }
}
