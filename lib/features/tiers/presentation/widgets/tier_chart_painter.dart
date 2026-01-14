import 'dart:math';
import 'package:cat_app_toy_project/core/constants/app/app_strings.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/pie_section.dart';
import '../../domain/entities/tier.dart';

final class TierChartPainter extends CustomPainter {
  final String indicatorLabel;
  final double indicatorValue;
  final double fontSize;
  final List<Tier> tiers;

  TierChartPainter(
      {required this.indicatorLabel,
      required this.indicatorValue,
      required this.fontSize,
      required this.tiers});

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY) - 60;

    /// Define the data
    List<PieSection> sections = tiers
        .map((e) => PieSection(
              seqNo: e.seqNo!,
              fontColorHex: e.fontColor!,
              bgColorHex: e.bgColor!,
              value: 1,
              tierName: e.tierName!.toUpperCase(),
              minPoint: e.minPoint!,
              maxPoint: e.maxPoint!,
            ))
        .toList()
      ..sort((a, b) =>
          a.seqNo.compareTo(b.seqNo)); /// Sort by seqNo in increasing order

    /// Draw the sections
    double totalValue = sections.fold(0, (sum, item) => sum + item.value);
    double startAngle = -pi / 2;

    for (var section in sections) {
      final sweepAngle = (section.value / totalValue) * 2 * pi;
      final paint = Paint()
        ..color = section.bgColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius / 2;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        sweepAngle * 0.98,
        false,
        paint,
      );

      /// Draw the inner curved text
      drawCurvedText(
        canvas,
        size,
        section.tierName,
        startAngle + sweepAngle / 2,
        radius,
        sweepAngle,
        TextStyle(color: section.fontColor, fontSize: fontSize),
      );

      var outerText = '${section.minPoint} - ${section.maxPoint}';

      drawCurvedText(
        canvas,
        size,
        outerText,
        startAngle + sweepAngle / 2,
        radius + 50,
        sweepAngle,
        TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      );

      ///Check if this is the section for the indicator
      if (section.tierName == indicatorLabel) {
        drawIndicator(
          canvas,
          centerX,
          centerY,
          radius,
          startAngle,
          sweepAngle,
          section.maxPoint.toDouble(),
          section.minPoint.toDouble(),
          indicatorValue, // Pass the indicator value
        );
      }

      startAngle += sweepAngle;
    }

    /// Draw center texts
    drawCenterTexts(canvas, size, centerX, centerY, radius);
  }

  void drawIndicator(
      Canvas canvas,
      double centerX,
      double centerY,
      double radius,
      double startAngle,
      double sweepAngle,
      double maxPoint,
      double minPoint,
      double indicatorValue) {
    /// Calculate the position of the indicator based on the indicator value
    double normalizedValue =
        (indicatorValue - minPoint) / (maxPoint - minPoint);
    double indicatorAngle = startAngle + (normalizedValue * sweepAngle);

    double innerRadius = radius * 0.6;
    double outerRadius = radius * 1.4;

    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0;

    final indicatorStartX = centerX + innerRadius * cos(indicatorAngle);
    final indicatorStartY = centerY + innerRadius * sin(indicatorAngle);
    final indicatorEndX = centerX + outerRadius * cos(indicatorAngle);
    final indicatorEndY = centerY + outerRadius * sin(indicatorAngle);

    /// Draw the indicator line
    canvas.drawLine(
      Offset(indicatorStartX, indicatorStartY),
      Offset(indicatorEndX, indicatorEndY),
      linePaint,
    );

    /// Draw the circle at the end of the indicator
    final circleRadius = 8.0;
    canvas.drawCircle(
        Offset(indicatorEndX, indicatorEndY), circleRadius, linePaint);
  }

  void drawCurvedText(Canvas canvas, Size size, String text, double angle,
      double radius, double sweepAngle, TextStyle textStyle) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    double totalTextWidth = textPainter.width;
    double textRadius = radius - textPainter.height / 2;
    double totalTextAngle = totalTextWidth / textRadius;

    /// Calculate the starting angle to center the text in the middle of the arc
    double startAngle = angle - totalTextAngle / 2;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final charPainter = TextPainter(
        text: TextSpan(text: char, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      charPainter.layout();

      double charWidth = charPainter.width;
      double charAngle = charWidth / textRadius;

      /// Calculate the position for each character
      double charPositionAngle = startAngle + charAngle / 2;
      final x = size.width / 2 + textRadius * cos(charPositionAngle);
      final y = size.height / 2 + textRadius * sin(charPositionAngle);

      /// Save and rotate the canvas
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(charPositionAngle + pi / 2);
      charPainter.paint(
          canvas, Offset(-charPainter.width / 2, -charPainter.height / 2));
      canvas.restore();

      startAngle += charAngle;
    }
  }

  void drawCenterTexts(
    Canvas canvas,
    Size size,
    double centerX,
    double centerY,
    double radius,
  ) {
    final texts = [
      indicatorLabel,
      AppStrings.tierLevel,
      indicatorValue.toString(),
      AppStrings.tierCredits,
      AppStrings.toNextTier
    ];

    /// Calculate font size and spacing dynamically based on canvas size
    double baseFontSize = size.width * 0.03; // 3% of the canvas width
    double minFontSize = 12; // Minimum font size
    double maxFontSize = 24; // Maximum font size

    /// Constrain the font size within min and max limits
    double fontSize = baseFontSize.clamp(minFontSize, maxFontSize);

    double baseSpacing = size.width * 0.01; // 1% of the canvas width
    double spaceBetweenTexts = baseSpacing.clamp(5, 15); // Constrain spacing

    final defaultTextStyle = TextStyle(
        color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.bold);
    final boldTextStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize * 1.5,
      fontWeight: FontWeight.bold,
    );

    final textPainters = texts.map((text) {
      TextStyle style;

      if (text == indicatorLabel || text == indicatorValue.toString()) {
        style = text == indicatorValue.toString()
            ? boldTextStyle
            : boldTextStyle.copyWith(color: Colors.red);
      } else {
        style = defaultTextStyle;
      }

      final painter = TextPainter(
        text: TextSpan(text: text, style: style),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      painter.layout();
      return painter;
    }).toList();

    /// Calculate total height including space between texts
    double totalHeight =
        textPainters.fold(0.0, (sum, painter) => sum + painter.height) +
            (textPainters.length - 1) * spaceBetweenTexts;

    double startY = centerY - totalHeight / 2 + 10;

    for (int i = 0; i < textPainters.length; i++) {
      final painter = textPainters[i];
      final textHeight = painter.height;
      final y = startY + textHeight / 2;

      /// Draw a card for the first set of texts (if needed)
      if (i == 0) {
        final cardWidth =
            max(textPainters[0].width, textPainters[1].width) + 20;
        final cardHeight =
            (textPainters[0].height + textPainters[1].height) + 16;

        /// Adjust the card's Y position to lift it further upward
        final cardYOffset = 20;

        final cardRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            centerX - cardWidth / 2,
            y - textPainters[0].height / 2 - cardYOffset,
            cardWidth,
            cardHeight,
          ),
          Radius.circular(8),
        );

        final cardPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

        /// Draw shadow for the card
        canvas.drawRRect(
          cardRect.shift(Offset(4, 4)),
          Paint()
            ..color = Colors.black.withOpacity(0.3)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4),
        );

        /// Draw the card
        canvas.drawRRect(cardRect, cardPaint);

        /// Draw the texts inside the card
        double cardStartY = y - textPainters[0].height / 2 - cardYOffset + 10;
        for (int j = 0; j <= 1; j++) {
          textPainters[j].paint(
              canvas, Offset(centerX - textPainters[j].width / 2, cardStartY));
          cardStartY +=
              textPainters[j].height + 2; // Add some spacing between the lines
        }

        /// Skip the next painter as it has been already drawn
        i++;
      } else {
        /// Draw the text without the card
        painter.paint(canvas, Offset(centerX - painter.width / 2, y));
      }

      startY += textHeight + spaceBetweenTexts;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
