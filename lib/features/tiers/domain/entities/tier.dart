import 'package:equatable/equatable.dart';

class Tier extends Equatable {
  final String? tierName;
  final int? minPoint;
  final int? maxPoint;
  final int? seqNo;
  final String? fontColor;
  final String? bgColor;
  final String? widgets;

  const Tier({
    required this.tierName,
    required this.minPoint,
    required this.maxPoint,
    required this.seqNo,
    required this.fontColor,
    required this.bgColor,
    required this.widgets,
  });

  @override
  List<Object?> get props =>
      [tierName, minPoint, maxPoint, seqNo, fontColor, bgColor, widgets];
}
