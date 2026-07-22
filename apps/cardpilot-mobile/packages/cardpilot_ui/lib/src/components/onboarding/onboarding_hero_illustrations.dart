import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

enum OnboardingIllustration { pilot, cashback, insights }

class OnboardingHeroIllustration extends StatelessWidget {
  const OnboardingHeroIllustration({required this.illustration, super.key});

  final OnboardingIllustration illustration;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _SkyPainter(),
      child: Center(
        child: switch (illustration) {
          OnboardingIllustration.pilot => const _PilotPlane(),
          OnboardingIllustration.cashback => const _CashbackCard(),
          OnboardingIllustration.insights => const _InsightsSparkle(),
        },
      ),
    );
  }
}

class _PilotPlane extends StatelessWidget {
  const _PilotPlane();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 260,
      height: 180,
      child: CustomPaint(painter: _PlanePainter()),
    );
  }
}

class _CashbackCard extends StatelessWidget {
  const _CashbackCard();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 260,
      height: 180,
      child: CustomPaint(painter: _CardPainter()),
    );
  }
}

class _InsightsSparkle extends StatelessWidget {
  const _InsightsSparkle();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 260,
      height: 180,
      child: CustomPaint(painter: _InsightsPainter()),
    );
  }
}

class _SkyPainter extends CustomPainter {
  const _SkyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        colors: [Color(0xFF0A78FF), Color(0xFF1BE0C7)],
      ).createShader(rect);
    canvas.drawRect(rect, skyPaint);

    // Stars (little rotated squares)
    final starPaint = Paint()..color = Colors.white.withValues(alpha: 0.9);
    final starPaint2 = Paint()..color = Colors.white.withValues(alpha: 0.65);
    _drawDiamond(canvas, const Offset(56, 88), 5, starPaint);
    _drawDiamond(canvas, Offset(size.width - 52, 110), 4, starPaint2);
    _drawDiamond(canvas, Offset(size.width - 86, 160), 3, starPaint);
    _drawDiamond(canvas, Offset(size.width * 0.72, 88), 2.5, starPaint2);

    // Soft trail behind the plane (subtle white swoosh).
    final trail = Path()
      ..moveTo(size.width * 0.18, size.height * 0.62)
      ..cubicTo(
        size.width * 0.28,
        size.height * 0.58,
        size.width * 0.34,
        size.height * 0.52,
        size.width * 0.46,
        size.height * 0.50,
      )
      ..cubicTo(
        size.width * 0.62,
        size.height * 0.48,
        size.width * 0.74,
        size.height * 0.40,
        size.width * 0.86,
        size.height * 0.32,
      );
    canvas.drawPath(
      trail,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.30)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.round,
    );

    // Bottom clouds.
    final cloudPaint = Paint()..color = Colors.white;
    final y = size.height * 0.80;
    _cloud(canvas, Offset(size.width * 0.05, y), 86, cloudPaint);
    _cloud(canvas, Offset(size.width * 0.38, y + 18), 110, cloudPaint);
    _cloud(canvas, Offset(size.width * 0.78, y + 6), 96, cloudPaint);
    canvas.drawRect(
      Rect.fromLTWH(0, y + 70, size.width, size.height),
      cloudPaint,
    );
  }

  void _drawDiamond(Canvas canvas, Offset c, double r, Paint paint) {
    final path = Path()
      ..moveTo(c.dx, c.dy - r)
      ..lineTo(c.dx + r, c.dy)
      ..lineTo(c.dx, c.dy + r)
      ..lineTo(c.dx - r, c.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _cloud(Canvas canvas, Offset c, double width, Paint paint) {
    final h = width * 0.42;
    final path = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(c.dx, c.dy + 8),
          width: width,
          height: h,
        ),
      )
      ..addOval(
        Rect.fromCenter(
          center: Offset(c.dx - width * 0.22, c.dy),
          width: width * 0.62,
          height: h * 0.95,
        ),
      )
      ..addOval(
        Rect.fromCenter(
          center: Offset(c.dx + width * 0.18, c.dy - 4),
          width: width * 0.74,
          height: h,
        ),
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PlanePainter extends CustomPainter {
  const _PlanePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.55, size.height * 0.44);

    // Body shadow
    canvas.drawOval(
      Rect.fromCenter(
        center: center + const Offset(0, 10),
        width: 190,
        height: 86,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.10),
    );

    // Wings
    final wingPaint = Paint()..color = AppColors.brandGreen;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center + const Offset(42, 22),
          width: 92,
          height: 26,
        ),
        const Radius.circular(18),
      ),
      wingPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center + const Offset(-42, 22),
          width: 92,
          height: 26,
        ),
        const Radius.circular(18),
      ),
      wingPaint,
    );

    // Tail fin
    final tailPath = Path()
      ..moveTo(center.dx + 60, center.dy - 38)
      ..quadraticBezierTo(
        center.dx + 108,
        center.dy - 30,
        center.dx + 118,
        center.dy - 4,
      )
      ..quadraticBezierTo(
        center.dx + 92,
        center.dy - 2,
        center.dx + 66,
        center.dy - 10,
      )
      ..close();
    canvas.drawPath(tailPath, Paint()..color = AppColors.brandBlue);

    // Body (blue base)
    final bodyRect = Rect.fromCenter(center: center, width: 200, height: 92);
    canvas.drawOval(bodyRect, Paint()..color = AppColors.brandBlue);

    // White top shell
    canvas.drawOval(
      Rect.fromCenter(
        center: center + const Offset(0, -10),
        width: 200,
        height: 78,
      ),
      Paint()..color = Colors.white,
    );

    // Cockpit window
    final cockpit = Rect.fromCenter(
      center: center + const Offset(-24, -6),
      width: 70,
      height: 52,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(cockpit, const Radius.circular(26)),
      Paint()..color = const Color(0xFF0B5CD1),
    );

    // Face (eyes + smile)
    final eyePaint = Paint()..color = Colors.white;
    canvas.drawCircle(cockpit.center + const Offset(-12, -4), 4.2, eyePaint);
    canvas.drawCircle(cockpit.center + const Offset(10, -4), 4.2, eyePaint);

    final smilePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;
    final smile = Path()
      ..moveTo(cockpit.center.dx - 10, cockpit.center.dy + 10)
      ..quadraticBezierTo(
        cockpit.center.dx,
        cockpit.center.dy + 20,
        cockpit.center.dx + 12,
        cockpit.center.dy + 10,
      );
    canvas.drawPath(smile, smilePaint);

    // Small highlight
    canvas.drawCircle(
      cockpit.center + const Offset(-18, -14),
      5.5,
      Paint()..color = Colors.white.withValues(alpha: 0.20),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CardPainter extends CustomPainter {
  const _CardPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width * 0.52, size.height * 0.48);

    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(-math.pi / 18);
    canvas.translate(-c.dx, -c.dy);

    final rect = Rect.fromCenter(center: c, width: 200, height: 128);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(28));
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A78FF), Color(0xFF1BE0C7)],
        ).createShader(rect),
    );

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Chip
    final chip = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: c + const Offset(-58, -14),
        width: 44,
        height: 34,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(
      chip,
      Paint()..color = Colors.white.withValues(alpha: 0.85),
    );
    canvas.drawRRect(
      chip,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Cashback badge
    final badgeRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: c + const Offset(58, 20), width: 78, height: 32),
      const Radius.circular(16),
    );
    canvas.drawRRect(badgeRect, Paint()..color = Colors.white);
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'CASHBACK',
        style: TextStyle(
          color: AppColors.brandBlue,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 78);
    textPainter.paint(
      canvas,
      Offset(
        badgeRect.center.dx - textPainter.width / 2,
        badgeRect.center.dy - textPainter.height / 2,
      ),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _InsightsPainter extends CustomPainter {
  const _InsightsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width * 0.50, size.height * 0.50);

    final ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawCircle(c, 56, ringPaint);
    canvas.drawCircle(
      c,
      56,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Center dot
    canvas.drawCircle(c, 10, Paint()..color = Colors.white);

    // Sparkles
    final p1 = Paint()..color = Colors.white.withValues(alpha: 0.95);
    final p2 = Paint()..color = Colors.white.withValues(alpha: 0.75);
    _diamond(canvas, c + const Offset(-78, -18), 9, p1);
    _diamond(canvas, c + const Offset(84, -40), 7, p2);
    _diamond(canvas, c + const Offset(54, 58), 6, p1);
  }

  void _diamond(Canvas canvas, Offset c, double r, Paint paint) {
    final path = Path()
      ..moveTo(c.dx, c.dy - r)
      ..lineTo(c.dx + r, c.dy)
      ..lineTo(c.dx, c.dy + r)
      ..lineTo(c.dx - r, c.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
