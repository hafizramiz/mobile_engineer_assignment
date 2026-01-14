import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/cat.dart';
import '../repositories/cats_repository.dart';

class FetchCats extends Usecase<String, List<Cat>, int?> {
  FetchCats(this.catRepository);

  final CatsRepository catRepository;

  @override
  Future<Either<Failure<String>, List<Cat>>> call() {
    return catRepository.getCats();
  }
}
