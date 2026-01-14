import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/fetch_cats.dart';
import 'cats_state.dart';

class CatsCubit extends Cubit<CatsState> {
  CatsCubit(this.fetchCats) : super(CatsInitial());

  final FetchCats fetchCats;

  void getCats() async {
    emit(CatsInProgress());
    final result = await fetchCats();
    result.when(
      error: (failure) => emit(CatsFailure(failure.error)),
      success: (users) {
        emit(CatsSuccess(users));
      },
    );
  }
}
