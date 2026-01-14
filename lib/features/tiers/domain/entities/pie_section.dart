
import 'dart:ui';

final class PieSection {
  final Color fontColor;
  final Color bgColor;
  final double value;
  final String tierName;
  final int minPoint;
  final int maxPoint;
  final int seqNo;

  PieSection({
    required this.seqNo,
    required String fontColorHex,
    required String bgColorHex,
    required this.value,
    required this.tierName,
    required this.minPoint,
    required this.maxPoint,
  })
      : fontColor = _colorFromHex(fontColorHex),
        bgColor = _colorFromHex(bgColorHex);

  static Color _colorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}