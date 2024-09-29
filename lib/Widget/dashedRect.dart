import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double borderRadius;
  final Widget child;

  const DashedRect({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.borderRadius = 8.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(strokeWidth / 2),
      child: CustomPaint(
        painter: DashRectPainter(
          color: color,
          strokeWidth: strokeWidth,
          gap: gap,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;
  final double borderRadius;

  DashRectPainter({
    this.strokeWidth = 2.0,
    this.color = Colors.red,
    this.gap = 4.0,
    this.borderRadius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path dashedPath = _getDashedPath(
      rect: Rect.fromLTWH(0, 0, size.width, size.height),
      gap: gap,
      borderRadius: borderRadius,
    );

    canvas.drawPath(dashedPath, dashedPaint);
  }

  Path _getDashedPath({
    required Rect rect,
    required double gap,
    required double borderRadius,
  }) {
    Path path = Path();
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    Path originalPath = Path()..addRRect(rrect);

    PathMetrics pathMetrics = originalPath.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < pathMetric.length) {
        double length = math.min(gap, pathMetric.length - distance);
        if (draw) {
          path.addPath(
            pathMetric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
