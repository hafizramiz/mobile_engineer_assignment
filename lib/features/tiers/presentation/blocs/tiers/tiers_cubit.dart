import 'package:cat_app_toy_project/features/tiers/presentation/blocs/tiers/tiers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/fetch_result_models.dart';




class TiersCubit extends Cubit<TiersState> {
  TiersCubit(this.fetchResultModels) : super(TiersInitial());

  final FetchResultModel fetchResultModels;

  void getTiers() async {
    emit(TiersInProgress());
    final result = await fetchResultModels();
    print(result);

    result.when(
      error: (failure) => emit(TiersFailure(failure.error)),
      success: (tiers) {
        emit(TiersSuccess(tiers,));
      },
    );
  }
}
