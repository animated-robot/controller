import 'dart:ui';

import 'package:controller/controller-stick.dart';
import 'package:controller/socket_service.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

const TextConfig config = TextConfig(fontSize: 24.0, fontFamily: 'Arial', color: Colors.white);

class Controller extends Game {
  final SocketService socketService;

  Size screenSize;
  double rectSize;

  Rect backgroundRect;
  Paint backgroundPaint;

  ControllerStick stick;
  Offset lastOffsetSent;

  Controller(this.socketService) {
    init();
  }

  void init() async {
    stick = ControllerStick(this);
    resize(await Flame.util.initialDimensions());
    lastOffsetSent = Offset(0, 0);
  }

  @override
  void render(Canvas canvas) {
    if (screenSize == null) {
      return;
    }

    canvas.drawRect(backgroundRect, backgroundPaint);
    stick.render(canvas);

    config.render(canvas, "Stick(" + stick.position.toString() + ")", Position(10, 20));
  }

  @override
  void update(double t) {
    stick.update(t);

    if (stick != null && socketService != null) {
      if (lastOffsetSent != stick.position) {
        if ((lastOffsetSent - stick.position).distance > .25) {
          this.lastOffsetSent = stick.position;
          this.socketService.sendPosition(
            Position.fromOffset(stick.position)
          );
        }
      }
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    rectSize = size.height / 9; // 9:16 ratio
    backgroundPaint = Paint()..color = Colors.black;
    backgroundRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    stick.init();
    super.resize(size);
  }

  void onPanStart(DragStartDetails details) {
    stick.onPanStart(details);
  }

  void onPanUpdate(DragUpdateDetails details) {
    stick.onPanUpdate(details);
  }

  void onPanEnd(DragEndDetails details) {
    stick.onPanEnd(details);
  }
}
