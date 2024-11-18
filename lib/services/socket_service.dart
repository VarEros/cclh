// services/socket_service.dart

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class SocketService with ChangeNotifier {
  late IO.Socket _socket;

  // Getter para el socket (puede ser útil para debug o casos especiales)
  IO.Socket get socket => _socket;

  // Estado de conexión
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  // Inicializa y conecta al servidor de Socket.IO
  void connect() {
    _socket = IO.io(
      'http://192.168.1.11:3000', // Cambia esto a la URL del backend si es necesario
      IO.OptionBuilder()
          .setTransports(['websocket']) // Usa solo WebSocket para evitar problemas de CORS
          .enableAutoConnect()
          .build(),
    );

    // Escuchar eventos de conexión y desconexión
    _socket.onConnect((_) {
      _isConnected = true;
      notifyListeners();
      print("Conectado al servidor de Socket.IO");
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      notifyListeners();
      print("Desconectado del servidor de Socket.IO");
    });

    // Manejo de errores
    _socket.onError((data) {
      print("Error de Socket.IO: $data");
    });
  }

  // Desconecta el socket al cerrar sesión o salir del juego
  void disconnect() {
    _socket.disconnect();
  }

  // Métodos para emitir eventos hacia el servidor

  void addPlayer(String playerName) {
    _socket.emit("addPlayer", playerName);
  }

  void startGame() {
    _socket.emit("startGame");
  }

  void startRound() {
    _socket.emit("startRound");
  }

  void playCard(String cardText) {
    _socket.emit("playCard", cardText);
  }

  void selectWinner(String winningPlayerId) {
    _socket.emit("selectWinner", winningPlayerId);
  }

  // Métodos de escucha (Listeners)

  void listenToEvent(String event, Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  void removeEventListener(String event) {
    _socket.off(event);
  }
}
