import 'package:flutter/material.dart';

abstract final class CardVisualStyle {
  static const _gradients = <LinearGradient>[
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF075DE7), Color(0xFF078CD7), Color(0xFF17C79E)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF5B2EFF), Color(0xFF8F3DDE), Color(0xFFE14B9A)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFF6B35), Color(0xFFF04452), Color(0xFFC026D3)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF102A56), Color(0xFF2948A8), Color(0xFF6D5CE7)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF087F5B), Color(0xFF0CA678), Color(0xFF15AABF)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF3730A3), Color(0xFF2563EB), Color(0xFF06B6D4)],
    ),
  ];

  static LinearGradient gradientFor(String cardId) {
    return _gradients[_stableHash(cardId) % _gradients.length];
  }

  // FNV-1a remains stable across rebuilds, app launches and devices.
  static int _stableHash(String value) {
    var hash = 0x811C9DC5;
    for (final codeUnit in value.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0x7FFFFFFF;
    }
    return hash;
  }
}
