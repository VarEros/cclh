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
  bool _winnerSelected = false;
  bool _playedCard = false;
  String? _myId;
  String? _myName;

  // Getters para acceder al estado desde la UI
  List<Player> get players => _players;
  List<String> get hand => _hand;
  List<SelectedCard> get cardsPlayed => _cardsPlayed;
  String? get currentBlackCard => _currentBlackCard;
  String? get currentJudge => _currentJudge;
  int get currentRound => _currentRound;
  bool get winnerSelected => _winnerSelected;
  bool get gameStarted => _gameStarted;
  bool get amIJudge => _myId==_currentJudge;
  bool get playedCard => _playedCard;
  String? get myName => _myName;


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

    _cardsPlayed = [];
    _winnerSelected = false;
    _gameStarted = true;
    notifyListeners();
  }

  void _handleNewRound(data) {
    if(!amIJudge) {
      _hand.removeWhere((card) => card == _cardsPlayed.firstWhere((cp) => cp.playerId == _myId).card);
      _hand.add(data['whiteCard']);
    }
    _cardsPlayed = [];
    _currentRound++;
    _currentBlackCard = data['blackCard'];
    _currentJudge = data['judge'];

    _winnerSelected = false;
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
    _winnerSelected = true;
    _playedCard = false;

    String winningPlayerId = data;
    _cardsPlayed.firstWhere((card) => card.playerId == winningPlayerId).isWinner = true;
    _players.firstWhere((player) => player.id == winningPlayerId).points++;
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
    _myName = playerName;
    _socketService.addPlayer(playerName);
  }

  void startGame() {
    _socketService.startGame();
  }

  void startRound() {
    _socketService.startRound();
  }

  void playCard(String cardText) {
    _playedCard = true;
    _socketService.playCard(cardText);
    notifyListeners();
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