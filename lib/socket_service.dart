import 'dart:async';
import 'dart:convert';

import 'package:controller/packet/context.dart';
import 'package:controller/packet/player.dart';
import 'package:controller/packet/register-player.dart';
import 'package:flame/position.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket socket;
  String sessionCode;

  Player player;

  Future<void> createSocketConnection(
    String serverAddress, Function onDisconect
  ) {
    Completer completer = Completer();

    socket = IO.io(serverAddress + '/input', <String, dynamic>{
      'transports': ['websocket'],
    });

    this.socket.on('connect', (_) {
      print('Connected');
      completer.complete();
    });

    this.socket.on('disconnect', (_) => onDisconect());

    return completer.future;
  }

  Future<void> registerPlayer(String sessionCode, String name) {
    Completer completer = Completer();

    this.player = Player(name, 'hotpink');

    String payload = jsonEncode(RegisterPlayer(
      sessionCode,
      this.player,
    ));

    print(payload);
    this.socket.emit('register_player', payload);
    
    this.socket.once('player_registered', (data) {
      this.sessionCode = sessionCode;
      this.player.id = data;
      completer.complete();
    });

    return completer.future;
  }

  sendPosition(Position direction) {
    String payload = jsonEncode(
      Context(this.sessionCode, this.player, direction)
    );

    print(payload);
    this.socket.emit('context', payload);
  }
}
