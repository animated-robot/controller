import 'package:controller/packet/player.dart';
import 'package:flame/position.dart';

class Context {
  final String sessionCode;
  final Position direction;
  final Player player;

  Context(this.sessionCode, this.player, this.direction);

  Map<String, dynamic> directionToJson() => {
    'x': direction.x,
    'y': direction.y,
  };

  Map<String, dynamic> toJson() => {
    'playerId': this.player.id,
    'sessionCode': this.sessionCode,
    'direction': this.directionToJson()
  };
}