import 'package:flutter/material.dart';

class SwTicketBorder extends ShapeBorder {
  final double radius;
  final Color? fillColor;
  final double borderWidth;
  final Color? borderColor;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  const SwTicketBorder({
    required this.radius,
    this.fillColor,
    this.borderWidth = 1.0,
    this.borderColor,
    this.topLeft = true,
    this.topRight = true,
    this.bottomLeft = true,
    this.bottomRight = true,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect, textDirection: textDirection), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _createPath(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (fillColor == null && borderColor == null) return;

    if (fillColor != null) {
      final fillPaint = Paint()
        ..color = fillColor! // Use the provided fillColor
        ..style = PaintingStyle.fill;
      final fillPath = getInnerPath(rect, textDirection: textDirection);
      canvas.drawPath(fillPath, fillPaint);
    }

    if (borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      final borderPath = getOuterPath(rect, textDirection: textDirection);
      canvas.drawPath(borderPath, borderPaint);
    }
  }

  Path _createPath(Rect rect) {
    // Inset the rect by the pathWidth so the border is inside the rect.
    Rect insetRect = rect.deflate(borderWidth);

    // The path for the 'ticket' shape
    Path path = Path();

    // The distance from the corner to start the curve for the inverted corners
    double inset = radius;

    // Move to the start point
    path.moveTo(insetRect.left + inset, insetRect.top);

    // Top line and top-right inverted corner
    path.lineTo(insetRect.right - inset, insetRect.top);
    path.arcToPoint(
      Offset(insetRect.right, insetRect.top + inset),
      radius: Radius.circular(inset),
      clockwise: !topRight,
    );

    // Right line and bottom-right inverted corner
    path.lineTo(insetRect.right, insetRect.bottom - inset);
    path.arcToPoint(
      Offset(insetRect.right - inset, insetRect.bottom),
      radius: Radius.circular(inset),
      clockwise: !bottomRight,
    );

    // Bottom line and bottom-left inverted corner
    path.lineTo(insetRect.left + inset, insetRect.bottom);
    path.arcToPoint(
      Offset(insetRect.left, insetRect.bottom - inset),
      radius: Radius.circular(inset),
      clockwise: !bottomLeft,
    );

    // Left line and top-left inverted corner
    path.lineTo(insetRect.left, insetRect.top + inset);
    path.arcToPoint(
      Offset(insetRect.left + inset, insetRect.top),
      radius: Radius.circular(inset),
      clockwise: !topLeft,
    );

    // Close the path
    path.close();

    return path;
  }

  @override
  ShapeBorder scale(double t) {
    return SwTicketBorder(
      radius: radius * t,
      borderWidth: borderWidth * t,
      borderColor: borderColor,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }
}