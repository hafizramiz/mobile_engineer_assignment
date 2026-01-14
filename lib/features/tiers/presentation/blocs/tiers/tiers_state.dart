import 'package:equatable/equatable.dart';

import '../../../../../shared/data/models/result_model.dart';


abstract class TiersState extends Equatable {
  const TiersState();
}

class TiersInitial extends TiersState {
  @override
  List<Object?> get props => [];
}

class TiersInProgress extends TiersState {
  @override
  List<Object?> get props => [];
}

class TiersFailure extends TiersState {
  const TiersFailure(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class TiersSuccess extends TiersState {
  const TiersSuccess(this.resultModel);

  final ResultModel resultModel;


  @override
  List<Object?> get props => [resultModel];
}
