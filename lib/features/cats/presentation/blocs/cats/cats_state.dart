import 'package:equatable/equatable.dart';

import '../../../domain/entities/cat.dart';

abstract class CatsState extends Equatable {
  const CatsState();
}

class CatsInitial extends CatsState {
  @override
  List<Object?> get props => [];
}

class CatsInProgress extends CatsState {
  @override
  List<Object?> get props => [];
}

class CatsFailure extends CatsState {
  const CatsFailure(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class CatsSuccess extends CatsState {
  const CatsSuccess(this.cats);

  final List<Cat> cats;

  @override
  List<Object?> get props => [cats];
}
