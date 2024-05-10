import 'dart:math' as math;

import 'package:contest_app/src/src.dart';

class HalfCircularProgressPainter extends CustomPainter {
  final double value;
  final Color color;
  final Color backgroundColor;

  HalfCircularProgressPainter({
    required this.value,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 6;
    final double radius = size.width / 2 - strokeWidth / 2;
    final double startAngle = -math.pi / 1; // start at 12 o'clock
    final double sweepAngle = math.pi; // sweep half circle

    // Draw background circle
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    // Draw progress circle
    Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius),
      startAngle,
      sweepAngle * value,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(HalfCircularProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
