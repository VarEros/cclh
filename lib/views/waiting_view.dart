import 'package:cclh/viewmodels/game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sala de Espera"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Jugadores en la sala:",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: gameViewModel.players.length,
                itemBuilder: (context, index) {
                  final player = gameViewModel.players[index];
                  return ListTile(
                    title: Text(player.name),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                gameViewModel.startGame();
              },
              child: const Text("Empezar Partida"),
            ),
          ],
        ),
      ),
    );
  }
}