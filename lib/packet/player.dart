class Player {
  String id;
  final String name;
  final String color;

  Player(this.name, this.color);

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'color': this.color,
  };
}