import 'package:controller/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

final _formKey = GlobalKey<FormState>();

class ConnectForm extends StatelessWidget {
  final Injector injector;
  final Function onSuccess;
  final Function onDisconect;

  ConnectForm(this.injector, this.onSuccess, this.onDisconect);

  @override
  Widget build(BuildContext context) {
    TextEditingController addressController = new TextEditingController(text: 'http://192.168.42.43:8080');
    bool sending = false;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'https://ip_address:port',
                labelText: 'Server address',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please type something :(';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: RaisedButton(
                onPressed: !sending ? () {
                  if (_formKey.currentState.validate()) {
                    // Process data.
                    sending = true;
                    final SocketService socketService = injector.get<SocketService>();
                    socketService
                      .createSocketConnection(addressController.text, this.onDisconect)
                      .then((_) => this.onSuccess())
                      .whenComplete(() {
                        sending = false;
                      })
                    ;
                  }
                } : null,
                child: Text('Connect'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}