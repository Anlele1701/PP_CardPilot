import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardPilotLogo extends StatelessWidget {
  const CardPilotLogo({
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    super.key,
  });

  static const assetName = 'assets/brandings/cardpilot_logo.svg';
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
      semanticsLabel: 'CardPilot logo',
    );
  }
}
