import 'package:controller/forms/connect-form.dart';
import 'package:controller/lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class FindServer extends StatelessWidget {
  final Injector injector;
  FindServer(this.injector);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect to a server'),
      ),
      body: ConnectForm(this.injector, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Lobby(injector)),
        );
      }, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindServer(injector)),
        );
      }),
    );
  }
}
