import 'package:cclh/models/Player.dart';

class GameRound {
  final int roundNumber;     // Número de la ronda actual
  final String judgeId;      // ID del jugador que es juez en esta ronda
  final String blackCard;      // Carta negra de la ronda actual
  final List<Player> players; // Lista de jugadores en la ronda
  
  GameRound({
    required this.roundNumber,
    required this.judgeId,
    required this.blackCard,
    required this.players,
  });
}