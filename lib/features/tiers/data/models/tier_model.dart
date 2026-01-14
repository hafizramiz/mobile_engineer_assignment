

import '../../domain/entities/tier.dart';

final class TierModel extends Tier {

  TierModel({
    super.tierName,
    super.minPoint,
    super.maxPoint,
    super.seqNo,
    super.fontColor,
    super.bgColor,
    super.widgets,
  });

  Map<String, dynamic> toJson() {
    return {
      'tierName': tierName,
      'minPoint': minPoint,
      'maxPoint': maxPoint,
      'seqNo': seqNo,
      'fontColor': fontColor,
      'bgColor': bgColor,
      'widgets': widgets,
    };
  }

  factory TierModel.fromJson(Map<String, dynamic> json) {
    return TierModel(
      tierName: json['tierName'] as String?,
      minPoint: json['minPoint'] as int?,
      maxPoint: json['maxPoint'] as int?,
      seqNo: json['seqNo'] as int?,
      fontColor: json['fontColor'] as String?,
      bgColor: json['bgColor'] as String?,
      widgets: json['widgets'] as String?,
    );
  }

  @override
  String toString() =>
      "Tiers(tierName: $tierName,minPoint: $minPoint,maxPoint: $maxPoint,seqNo: $seqNo,fontColor: $fontColor,bgColor: $bgColor,widgets: $widgets)";

  @override
  int get hashCode => Object.hash(
      tierName, minPoint, maxPoint, seqNo, fontColor, bgColor, widgets);

  @override
  // TODO: implement props
  List<Object?> get props => [
    tierName,
    minPoint,
    maxPoint,
    seqNo,
    fontColor,
    bgColor,
    widgets,];

}
