import 'package:controller/controller-screen.dart';
import 'package:controller/forms/join-game-form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class Lobby extends StatelessWidget {
  final Injector injector;
  Lobby(this.injector);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lobby'),
      ),
      body: JoinGameForm(this.injector, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ControllerScreen(this.injector)),
        );
      }),
    );
  }
}
