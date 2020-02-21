import 'dart:math';

import 'package:controller/controller.dart';
import 'package:flutter/material.dart';

class ControllerStick {
  final Controller controller;

  Rect backgroundRect;
  Paint backgroundPaint;
  double backgroundAspectRatio = 2.5;

  Rect knobRect;
  Paint knobPaint;
  double knobAspectRatio = 1.2;

  bool dragging = false;
  Offset dragPosition;
  Offset position;

  ControllerStick(this.controller) {
    backgroundPaint = Paint()..color = Colors.redAccent;
    knobPaint = Paint()..color = Colors.tealAccent;
  }

  void init() {
    var radius = (controller.rectSize * backgroundAspectRatio) / 2;
    Offset osBackground = Offset(
      50 + (radius * 2),
      (controller.screenSize.height / 2) + radius
    );
    backgroundRect = Rect.fromCircle(center: osBackground, radius: radius);

    radius = (controller.rectSize * knobAspectRatio) / 2;
    Offset osKnob = Offset(backgroundRect.center.dx, backgroundRect.center.dy);
    knobRect = Rect.fromCircle(center: osKnob, radius: radius);

    dragPosition = knobRect.center;
  }

  void render(Canvas canvas) {
    canvas.drawRect(backgroundRect, backgroundPaint);
    canvas.drawRect(knobRect, knobPaint);
  }

  void update(double t) {
    if (dragging) {
      double radAngle = atan2(
        dragPosition.dy - backgroundRect.center.dy,
        dragPosition.dx - backgroundRect.center.dx
      );

      Point p = Point(backgroundRect.center.dx, backgroundRect.center.dy);
      double dist = p.distanceTo(Point(dragPosition.dx, dragPosition.dy));

      if (dist >= (controller.rectSize  * backgroundAspectRatio / 2)) {
        dist = controller.rectSize  * backgroundAspectRatio / 2;
      }

      double nextX = dist * cos(radAngle);
      double nextY = dist * sin(radAngle);
      Offset nextPosition = Offset(nextX, nextY);

      Offset diff = Offset(
        backgroundRect.center.dx + nextPosition.dx,
        backgroundRect.center.dy + nextPosition.dy
      ) - knobRect.center;

      diff = Offset(
        num.parse(diff.dx.toStringAsFixed(2)),
        num.parse(diff.dy.toStringAsFixed(2)),
      );
      
      knobRect = knobRect.shift(diff);
    } else {
      Offset diff = dragPosition - knobRect.center;
      knobRect = knobRect.shift(diff);
    }

    position = (knobRect.center - backgroundRect.center) / (backgroundRect.width/2);
  }

  // Knob movement

  void onPanStart(DragStartDetails details) {
    if (knobRect.contains(details.globalPosition)) {
      dragging = true;
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (dragging) {
      dragPosition = details.globalPosition;
    }
  }

  void onPanEnd(DragEndDetails details) {
    dragging = false;
    dragPosition = backgroundRect.center;
  }
}
