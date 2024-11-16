import 'package:cclh/models/selected_card.dart';
import 'package:flutter/material.dart';
import '../services/socket_service.dart';
import '../models/player.dart'; // Asegúrate de importar el modelo de Player

class GameViewModel with ChangeNotifier {
  final SocketService _socketService;

  List<Player> _players = [];
  List<String> _hand = [];  // Cartas blancas en mano del jugador actual
  List<SelectedCard> _cardsPlayed = [];
  String? _currentBlackCard; // Carta negra actual
  String? _currentJudge;     // Juez actual
  int _currentRound = 0;
  bool _gameStarted = false;
  bool _roundStarted = false;
  String? _myId;

  // Getters para acceder al estado desde la UI
  List<Player> get players => _players;
  List<String> get hand => _hand;
  List<SelectedCard> get cardsPlayed => _cardsPlayed;
  String? get currentBlackCard => _currentBlackCard;
  String? get currentJudge => _currentJudge;
  int get currentRound => _currentRound;
  bool get roundStarted => _roundStarted;
  bool get gameStarted => _gameStarted;
  bool get amIJudge => _myId==_currentJudge;

  String getPlayerName(String playerId) => _players.firstWhere((player) => player.id == playerId).name;

  GameViewModel(this._socketService) {
    // Conectar el servicio de socket y establecer listeners para eventos
    _socketService.connect();
    _initializeListeners();
  }

  // Iniciar los listeners de eventos del servicio
  void _initializeListeners() {
    _socketService.socket.on("newGame", (data) => _handleNewGame(data));
    _socketService.socket.on("newRound", (data) => _handleNewRound(data));
    _socketService.socket.on("allCardsPlayed", (data) => _handleAllCardsSelected(data));
    _socketService.socket.on("roundWinner", (data) => _handleRoundWinner(data));
    _socketService.socket.on("updatePlayers", (data) => _handleUpdatePlayers(data));
    _socketService.socket.on("PlayerRemoved", (data) => _handlePlayerRemoved(data));
  }

  // Métodos para manejar los eventos de Socket.IO
  void _handleNewGame(data) {
    _currentRound = 1;
    _currentBlackCard = data['blackCard'];
    _currentJudge = data['judge'];
    _hand = List<String>.from(data['hand']);
  
    print('nuevo juego iniciado');
    _gameStarted = true;
    notifyListeners();
  }

    void _handleNewRound(data) {
    _cardsPlayed = [];
    _currentRound++;
    _currentBlackCard = data['blackCard'];
    _currentJudge = data['judge'];
  
    _roundStarted = true;
    notifyListeners();
  }

  void _handleAllCardsSelected(data) {
    // Actualiza el estado en respuesta a una carta jugada
    _cardsPlayed = (data as List).map((cardData) => SelectedCard(
      playerId: cardData['playerId'], 
      card: cardData['card']
    )).toList();
    // Puedes actualizar el estado si es necesario, por ejemplo, registrando qué cartas han sido jugadas
    notifyListeners();
  }

  void _handleRoundWinner(data) {
    _roundStarted = false;
    String winningPlayerId = data['winningPlayerId'] as String;
    _cardsPlayed.firstWhere((card) => card.playerId == winningPlayerId).isWinner = true;
    // Actualiza el estado del juego según el ganador y reinicia para una nueva ronda
    notifyListeners();
  }

  void _handleUpdatePlayers(data) {
    _myId ??= _socketService.socket.id; 
    _players = data.map((playerData) => Player.fromJson(playerData)).toList().cast<Player>();
    print("Nuevo Jugador: ${_players.last.name}");
    notifyListeners();
  }

  void _handlePlayerRemoved(data) {
    _players.removeWhere((player) => player.id == data);
    print("Jugador Eliminado");
    notifyListeners();
  }


  // Métodos para interactuar con el servicio de Socket.IO
  void addPlayer(String playerName) {
    _socketService.addPlayer(playerName);
  }

  void startGame() {
    _socketService.startGame();
  }

  void startRound() {
    _socketService.startRound();
  }

  void playCard(String cardText) {
    _socketService.playCard(cardText);
  }

  void selectWinner(String winningPlayerId) {
    _socketService.selectWinner(winningPlayerId);
  }

  // Método de limpieza
  @override
  void dispose() {
    _socketService.disconnect();
    super.dispose();
  }
}