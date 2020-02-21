import 'package:controller/controller.dart';
import 'package:controller/socket_service.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class ControllerScreen extends StatelessWidget {
  final Injector injector;
  ControllerScreen(this.injector);

  @override
  Widget build(BuildContext context) {
    final SocketService socketService = injector.get<SocketService>();
    Controller controller = Controller(socketService);
    buildFlame(controller);

    return controller.widget;
  }
  
  buildFlame(Controller controller) async {
    Util utils = Util();
    await utils.fullScreen();
    await utils.setOrientation(DeviceOrientation.landscapeLeft);

    utils.addGestureRecognizer(
      new PanGestureRecognizer()
        ..onStart = controller.onPanStart
        ..onUpdate = controller.onPanUpdate
        ..onEnd = controller.onPanEnd
    );
  }
}