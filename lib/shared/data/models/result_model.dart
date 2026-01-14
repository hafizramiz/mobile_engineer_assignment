import '../../../core/models/base_model.dart';
import '../../../features/cats/data/models/cat_model.dart';
import '../../../features/tiers/data/models/tier_model.dart';

final class ResultModel extends BaseModel<ResultModel>{
  List<CatModel>? cats;
  List<TierModel>? tiers;
  String? currentTier;
  int? tierPoints;

  ResultModel({
    this.cats,
    this.tiers,
    this.currentTier,
    this.tierPoints,
  });

  Map<String, dynamic> toJson() {
    return {
      'cats': cats,
      'tiers': tiers,
      'currentTier': currentTier,
      'tierPoints': tierPoints,
    };
  }

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      cats: (json['cats'] as List<dynamic>?)
          ?.map((e) => CatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tiers: (json['tiers'] as List<dynamic>?)
          ?.map((e) => TierModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentTier: json['currentTier'] as String?,
      tierPoints: json['tierPoints'] as int?,
    );
  }

  @override
  String toString() =>
      "Result(cats: $cats,tiers: $tiers,currentTier: $currentTier,tierPoints: $tierPoints)";

  @override
  int get hashCode => Object.hash(cats, tiers, currentTier, tierPoints);

  @override
  ResultModel fromJson(json) {
    return ResultModel.fromJson(json);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [cats, tiers, currentTier, tierPoints];

}