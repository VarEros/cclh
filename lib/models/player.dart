class Player {
  final String id;           // Identificador único del jugador (normalmente el ID de Socket.IO)
  final String name;         // Nombre del jugador
  List<String> hand;         // Lista de cartas blancas en la mano del jugador
  int points;                // Puntuación acumulada del jugador
  
  Player({
    required this.id,
    required this.name,
    required this.hand,
    this.points = 0,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      hand: List<String>.from(json['hand'] ?? []),
      points: json['points']
    );
  }

  // Métodos de utilidad para actualizar la mano, puntos, etc., si es necesario
}