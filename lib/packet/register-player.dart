import 'package:controller/packet/player.dart';

class RegisterPlayer {
  final String sessionCode;
  final Player player;

  RegisterPlayer(this.sessionCode, this.player);

  Map<String, dynamic> toJson() => {
    'sessionCode': this.sessionCode,
    'player': this.player.toJson(),
  };
}