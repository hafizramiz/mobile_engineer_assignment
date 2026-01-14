import 'package:mobile_engineer_assignment/features/tiers/presentation/widgets/tier_chart_painter.dart';
import 'package:flutter/material.dart';
import '../../../../core/config/q.dart';
import '../../../../shared/data/models/result_model.dart';

class TierChart extends StatelessWidget {
  final ResultModel resultModel;

  TierChart({required this.resultModel});

  @override
  Widget build(BuildContext context) {
    Q.deviceWidth = MediaQuery.of(context).size.width;
    Q.deviceHeight = MediaQuery.of(context).size.height;
    double chartSize = Q.deviceWidth * 0.9;
    double fontSize = chartSize * 0.04;

    return Center(
      child: CustomPaint(
        size: Size(chartSize, chartSize),
        painter: TierChartPainter(
          indicatorLabel: resultModel.currentTier?.toUpperCase() ?? "",
          indicatorValue: resultModel.tierPoints?.toDouble() ?? 0.0,
          fontSize: fontSize,
          tiers: resultModel.tiers ?? [],
        ),
      ),
    );
  }
}
