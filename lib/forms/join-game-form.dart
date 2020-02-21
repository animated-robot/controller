import 'package:controller/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

final _formKey = GlobalKey<FormState>();

class JoinGameForm extends StatelessWidget {
  final Injector injector;
  final Function onSuccess;

  JoinGameForm(this.injector, this.onSuccess);

  @override
  Widget build(BuildContext context) {
    TextEditingController sessionCodeController = new TextEditingController(text: 'S31C');
    TextEditingController usernameController = new TextEditingController(text: 'Vornian');

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: sessionCodeController,
              decoration: const InputDecoration(
                hintText: 'Game session code',
                labelText: 'Session code',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please type the game session code';
                }
                return null;
              },
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'My cool username',
                labelText: 'Username',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'You shall not be nameless';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    // Process data.
                    final SocketService socketService = injector.get<SocketService>();
                    await socketService.registerPlayer(
                      sessionCodeController.text,
                      usernameController.text,
                    );
                    this.onSuccess();
                  }
                },
                child: Text('Join'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}