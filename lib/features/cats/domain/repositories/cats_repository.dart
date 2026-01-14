
import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../entities/cat.dart';

abstract class CatsRepository {
  Future<Either<Failure<String>, List<Cat>>> getCats();
}
