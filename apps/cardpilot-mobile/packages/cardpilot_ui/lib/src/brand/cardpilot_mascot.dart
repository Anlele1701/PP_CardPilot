import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardPilotMascot extends StatelessWidget {
  const CardPilotMascot({
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    super.key,
  });

  static const assetName = 'assets/brandings/cardpilot_mascot.svg';
  static const packageName = 'cardpilot_ui';

  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      package: packageName,
      width: width,
      height: height,
      fit: fit,
      semanticsLabel: 'CardPilot mascot',
    );
  }
}
